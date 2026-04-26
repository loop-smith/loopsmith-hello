import { describe, it, expect } from 'vitest'

// This file proves Vitest is wired. The canonical template carries no
// real test coverage — downstream clones add tests as features emerge.
// If you're forking loopsmith-hello, replace this file with the first
// real test of your project's actual behavior.

describe('loopsmith-hello toolchain sanity', () => {
  it('vitest runs', () => {
    expect(1 + 1).toBe(2)
  })
})
