import { useState } from 'react'

function App() {
  const [message, setMessage] = useState('')

  const handleApiCall = async () => {
    const apiUrl = 'https://branubrain-fs-dev-115966255603.asia-northeast1.run.app';
    const res = await fetch(`${apiUrl}/health`);
    const data = await res.json();
    setMessage(data.status);
  }

  return (
    <>
      <h1>Branubrain dev</h1>
      <p>{message}</p>
      <button onClick={handleApiCall}>API Test</button>
    </>
  )
}

export default App
