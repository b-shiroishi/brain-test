import { useState } from 'react'

function App() {
  const [message, setMessage] = useState('')

  const handleApiCall = async () => {
    const apiUrl = import.meta.env.VITE_BACKEND_API_URL || 'http://localhost:8000';
    const res = await fetch(`${apiUrl}/health`);
    const data = await res.json();
    setMessage(data.status);
  }

  return (
    <>
      <h1>Branubrain dev</h1>
      <p>{message}</p>
      <button onClick={handleApiCall}>API Test2</button>
    </>
  )
}

export default App
