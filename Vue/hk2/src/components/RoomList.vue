<template>
  <div class="inner">
    <ul id="typerdo">
      <li v-for="(t, idx) in roomTypes" :key="t.value">
        <input
          type="radio"
          :id="'typerdo_' + idx"
          name="typerdo"
          :value="t.value"
          v-model="selectedType"
        />
        <label :for="'typerdo_' + idx">
          <span class="type_name">{{ t.label }}</span>
          <span class="type_cnt">{{ roomCounts[t.value] }}</span>
        </label>
      </li>
    </ul>

    <div class="villa_list">
      <ul>
        <li v-for="room in filteredRooms" :key="room.id">
          <a href="#" :class="room.status" @click.prevent="changeStatus(room)">
            {{ room.name }}
          </a>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import type { Room } from '../types/room'
import { getRooms, updateRoomStatus } from '../api/roomService'

const roomTypes = [
  { value: 'A', label: '퇴실예정' },
  { value: 'B', label: '퇴실완료' },
  { value: 'C', label: '청소중' },
  { value: 'D', label: '청소완료' },
  { value: 'E', label: '재실' },
  { value: 'F', label: '점검요청' },
  { value: 'G', label: '점검완료' }
]

const rooms = ref<Room[]>([])
const selectedType = ref('A')

const filteredRooms = computed(() =>
  rooms.value.filter(r => r.status === selectedType.value)
)

const roomCounts = computed<Record<string, number>>(() => {
  return roomTypes.reduce((acc: Record<string, number>, t) => {
    acc[t.value] = rooms.value.filter(r => r.status === t.value).length
    return acc
  }, {})
})

const loadRooms = async () => {
  rooms.value = await getRooms()
}

const changeStatus = async (room: Room) => {
  const nextStatus = prompt(`상태 변경 (현재: ${room.status})`, room.status)
  if (nextStatus && nextStatus !== room.status) {
    await updateRoomStatus(room.id, nextStatus)
    await loadRooms()
  }
}

onMounted(loadRooms)
</script>
