import type { RoomOverviewResponseDto, RoomDto } from '@/types/room'

export async function getRoomOverview(): Promise<RoomOverviewResponseDto> {
    const res = await fetch('/api/v1/rooms/overview')
    if (!res.ok) {
        throw new Error('객실 현황 정보를 불러오는 데 실패했습니다.')
    }
    return await res.json()
}

export async function updateRoomStatus(dto: RoomDto): Promise<void> {
    const res = await fetch('api/v1/rooms/status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(dto)
    })
    if (!res.ok) {
        throw new Error('객실 상태 변경에 실패했습니다.')
    }
}
