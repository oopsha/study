// 타입 정의만 관리하는 파일

export interface RoomDto {
  faciPart: string
  roomNo: string
  roomStat: string
}

export interface RoomStatusCountDto {
  roomStat: string
  roomStatCnt: number
}

export interface RoomOverviewResponseDto {
  statusCounts: RoomStatusCountDto[]
  rooms: RoomDto[]
}
