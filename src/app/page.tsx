'use client'

import { useEffect, useState } from 'react'
import { supabase } from '@/lib/supabase'

type Note = {
  id: string
  body: string
  created_at: string
}

export default function Home() {
  const [notes, setNotes] = useState<Note[]>([])
  const [body, setBody] = useState('')
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    loadNotes()
  }, [])

  async function loadNotes() {
    setLoading(true)
    const { data, error } = await supabase
      .from('notes')
      .select('*')
      .order('created_at', { ascending: false })
    if (error) setError(error.message)
    else setNotes(data ?? [])
    setLoading(false)
  }

  async function addNote(e: React.FormEvent) {
    e.preventDefault()
    const trimmed = body.trim()
    if (!trimmed) return
    const { data, error } = await supabase
      .from('notes')
      .insert({ body: trimmed })
      .select()
      .single()
    if (error) {
      setError(error.message)
      return
    }
    setNotes((prev) => [data as Note, ...prev])
    setBody('')
  }

  async function deleteNote(id: string) {
    const { error } = await supabase.from('notes').delete().eq('id', id)
    if (error) {
      setError(error.message)
      return
    }
    setNotes((prev) => prev.filter((n) => n.id !== id))
  }

  return (
    <main className="mx-auto max-w-xl p-8 font-sans">
      <h1 className="text-2xl font-semibold mb-6">loopsmith-hello · notes</h1>

      <form onSubmit={addNote} className="flex gap-2 mb-6">
        <input
          value={body}
          onChange={(e) => setBody(e.target.value)}
          placeholder="write a note"
          className="flex-1 rounded border border-gray-300 px-3 py-2"
        />
        <button
          type="submit"
          className="rounded bg-black px-4 py-2 text-white disabled:opacity-40"
          disabled={!body.trim()}
        >
          Add
        </button>
      </form>

      {error && (
        <div className="mb-4 rounded border border-red-300 bg-red-50 px-3 py-2 text-sm text-red-700">
          {error}
        </div>
      )}

      {loading ? (
        <p className="text-gray-500">loading…</p>
      ) : notes.length === 0 ? (
        <p className="text-gray-500">no notes yet</p>
      ) : (
        <ul className="space-y-2">
          {notes.map((note) => (
            <li
              key={note.id}
              className="flex items-start justify-between gap-3 rounded border border-gray-200 px-3 py-2"
            >
              <div>
                <p>{note.body}</p>
                <p className="text-xs text-gray-400">
                  {new Date(note.created_at).toLocaleString()}
                </p>
              </div>
              <button
                onClick={() => deleteNote(note.id)}
                className="text-sm text-red-600 hover:underline"
              >
                Delete
              </button>
            </li>
          ))}
        </ul>
      )}
    </main>
  )
}
