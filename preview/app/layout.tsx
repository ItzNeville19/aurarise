import './globals.css'

export const metadata = {
  title: 'STOMP - Premium Sports App Preview',
  description: 'Preview of STOMP, a premium iOS app for action-sport athletes',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
