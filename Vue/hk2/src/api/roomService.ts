import type { Room } from '../types/room'

export async function getRooms(): Promise<Room[]> {
//   const res = await fetch('/api/rooms')
//   return await res.json()

  return [];
}

export async function updateRoomStatus(id: number, status: string): Promise<void> {
//   await fetch('/api/rooms/update', {
//     method: 'POST',
//     headers: { 'Content-Type': 'application/json' },
//     body: JSON.stringify({ id, status })
//   })
}
