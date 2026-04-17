interface ChecklistItemProps {
  label: string
  checked: boolean
  onChange: (checked: boolean) => void
}

export function ChecklistItem({ label, checked, onChange }: ChecklistItemProps) {
  return (
    <label className="flex items-start gap-3 cursor-pointer select-none">
      <button
        role="checkbox"
        aria-checked={checked}
        onClick={() => onChange(!checked)}
        className={`mt-0.5 flex-shrink-0 w-5 h-5 border-2 flex items-center justify-center transition-colors focus:outline-none ${
          checked ? 'border-gold bg-gold' : 'border-muted bg-transparent'
        }`}
      >
        {checked && (
          <svg width="10" height="8" viewBox="0 0 10 8" fill="none" aria-hidden>
            <path
              d="M1 4l3 3 5-6"
              stroke="white"
              strokeWidth="1.8"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
          </svg>
        )}
      </button>
      <span
        className={`font-sans text-sm leading-relaxed pt-0.5 transition-colors ${
          checked ? 'text-muted line-through' : 'text-ink'
        }`}
      >
        {label}
      </span>
    </label>
  )
}
