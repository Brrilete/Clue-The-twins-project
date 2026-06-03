import axios from 'axios'

const api = axios.create({
  baseURL: '/api',
  headers: {
    
  }
})

export default api