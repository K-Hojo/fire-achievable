import { render, screen } from '@testing-library/react'

import Home from '../page'

describe('Home', () => {
  it('renders a welcome message', () => {
    render(<Home />)
    expect(screen.getByRole('main')).toBeInTheDocument()
  })
})
