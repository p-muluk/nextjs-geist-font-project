import type { NextIntlConfig } from 'next-intl'

const nextIntlConfig: NextIntlConfig = {
  locales: ['en', 'hi', 'mr'],
  defaultLocale: 'en',
  // Optionally specify the directory where your translation files are located
  // messagesDirectory: './messages',
}

export default nextIntlConfig
