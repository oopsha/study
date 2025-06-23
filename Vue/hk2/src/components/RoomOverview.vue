<template>
    <div class="inner">
        <!-- 상단 객실상태 요약 -->
        <ul id="typerdo" groupname="typerdo">
            <li v-for="(t, idx) in statusCounts" :key="t.roomStat">
                <input type="radio" :id="'typerdo_' + idx" name="typerdo" :value="t.roomStat" v-model="selectedType"
                    :disabled="!['C', 'D'].includes(t.roomStat)" />
                <label :for="'typerdo_' + idx">
                    <span class="type_name">{{ t.roomStatNm }}</span>
                    <span class="type_cnt">{{ t.roomStatCnt }}</span>
                </label>
            </li>
        </ul>

        <!-- 왼쪽 그룹 -->
        <div class="villa_list">
            <div v-for="group in leftGroups" :key="group.faciPart">
                <ul>
                    <h3>{{ group.faciPart }}</h3>
                    <li v-for="room in group.rooms" :key="room.roomNo">
                        <a :class="room.roomStat" @click="changeStatus(room)">
                            {{ room.roomNo }}
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 오른쪽 그룹 -->
        <div class="villa_list">
            <div v-for="group in rightGroups" :key="group.faciPart">
                <ul>
                    <h3>{{ group.faciPart }}</h3>
                    <li v-for="room in group.rooms" :key="room.roomNo">
                        <a :class="room.roomStat" @click="changeStatus(room)">
                            {{ room.roomNo }}
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { getRoomOverview, updateRoomStatus } from '@/api/roomService'
import type { RoomDto, RoomStatusCountDto, RoomOverviewResponseDto } from '@/types/room'

const roomTypes = [
    { value: 'A', label: '퇴실예정' },
    { value: 'B', label: '퇴실완료' },
    { value: 'C', label: '청소중' },
    { value: 'D', label: '청소완료' },
    { value: 'E', label: '재실' },
    { value: 'F', label: '점검요청' },
    { value: 'G', label: '고장' }
]

const selectedType = ref('C')

const rawStatusCounts = ref<RoomStatusCountDto[]>([])
const rawRooms = ref<RoomDto[]>([])

const statusCounts = computed(() => {
    const map = new Map<string, number>()
    rawStatusCounts.value.forEach(sc => {
        map.set(sc.roomStat, sc.roomStatCnt)
    })

    return roomTypes.map(t => ({
        roomStat: t.value,
        roomStatNm: t.label,
        roomStatCnt: map.get(t.value) || 0
    }))
})

const loadOverview = async () => {
    try {
        const data: RoomOverviewResponseDto = await getRoomOverview()
        rawStatusCounts.value = data.statusCounts
        rawRooms.value = data.rooms
    } catch (error) {
        console.error('객실 현황 불러오기 실패:', error)
    }
}

// FACI_PART 기준으로 그룹화
const groupedMap = computed(() => {
    return rawRooms.value.reduce<Record<string, RoomDto[]>>((acc, room) => {
        if (!acc[room.faciPart]) acc[room.faciPart] = []
        acc[room.faciPart].push(room)
        return acc
    }, {})
})

// 그룹을 배열로 변환
const groupedArray = computed(() =>
    Object.entries(groupedMap.value).map(([faciPart, rooms]) => ({
        faciPart,
        rooms
    }))
)

// 반 나누기 (홀수면 왼쪽이 더 많음)
const midIndex = computed(() => Math.ceil(groupedArray.value.length / 2))

const leftGroups = computed(() => groupedArray.value.slice(0, midIndex.value))
const rightGroups = computed(() => groupedArray.value.slice(midIndex.value))

const changeStatus = async (room: RoomDto) => {
    if (room.roomStat === selectedType.value) return;
    
    if (!['C', 'D'].includes(selectedType.value)) {
        alert('청소중, 청소완료 상태로만 변경할 수 있습니다.')
        return
    }

    try {
        await updateRoomStatus({ ...room, roomStat: selectedType.value })
        await loadOverview();
    } catch (error) {
        console.error(`상태 변경 실패 : ${error}`);
    }
}

let intervalId: ReturnType<typeof setInterval> | null = null

onMounted(() => {
  loadOverview()
  intervalId = setInterval(loadOverview, 30000) // 30초마다 새로고침
})

onUnmounted(() => {
  if (intervalId) clearInterval(intervalId)
})
</script>
