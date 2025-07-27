'use client'

import React from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { useTranslations } from 'next-intl'
import { Button } from '@/components/ui/button'
import { Sheet, SheetContent, SheetTrigger } from '@/components/ui/sheet'
import { ScrollArea } from '@/components/ui/scroll-area'
import { cn } from '@/lib/utils'
import { useSidebarStore } from '@/lib/sidebar-store'
import {
  Home,
  Users,
  Building,
  BookOpen,
  Calendar,
  Settings,
  Menu,
  LogOut,
  GraduationCap,
  Library,
  DollarSign,
  BarChart3
} from 'lucide-react'

interface SidebarProps {
  className?: string
}

const navigation = [
  { name: 'dashboard', href: '/dashboard', icon: Home },
  { name: 'institutes', href: '/institutes', icon: Building },
  { name: 'students', href: '/students', icon: Users },
  { name: 'teachers', href: '/teachers', icon: GraduationCap },
  { name: 'courses', href: '/courses', icon: BookOpen },
  { name: 'attendance', href: '/attendance', icon: Calendar },
  { name: 'library', href: '/library', icon: Library },
  { name: 'fees', href: '/fees', icon: DollarSign },
  { name: 'reports', href: '/reports', icon: BarChart3 },
  { name: 'settings', href: '/settings', icon: Settings },
]

export function Sidebar({ className }: SidebarProps) {
  const t = useTranslations('common')
  const pathname = usePathname()
  const { isOpen, toggle, close } = useSidebarStore()

  const NavItems = () => (
    <div className="space-y-2">
      {navigation.map((item) => {
        const Icon = item.icon
        const isActive = pathname === item.href
        
        return (
          <Link
            key={item.href}
            href={item.href}
            className={cn(
              'flex items-center space-x-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors',
              isActive
                ? 'bg-primary text-primary-foreground'
                : 'text-muted-foreground hover:bg-accent hover:text-accent-foreground'
            )}
            onClick={close}
          >
            <Icon className="h-4 w-4" />
            <span>{t(item.name)}</span>
          </Link>
        )
      })}
    </div>
  )

  return (
    <>
      {/* Mobile Sidebar */}
      <Sheet open={isOpen} onOpenChange={toggle}>
        <SheetTrigger asChild>
          <Button
            variant="ghost"
            size="icon"
            className="lg:hidden fixed top-4 left-4 z-50"
          >
            <Menu className="h-5 w-5" />
          </Button>
        </SheetTrigger>
        <SheetContent side="left" className="w-64 p-0">
          <div className="flex h-full flex-col">
            <div className="flex items-center justify-between p-4 border-b">
              <h2 className="text-lg font-semibold">Scholar Bee</h2>
            </div>
            <ScrollArea className="flex-1 p-4">
              <NavItems />
            </ScrollArea>
            <div className="border-t p-4">
              <Button
                variant="ghost"
                className="w-full justify-start"
                onClick={() => {
                  // Handle logout
                  close()
                }}
              >
                <LogOut className="h-4 w-4 mr-2" />
                {t('logout')}
              </Button>
            </div>
          </div>
        </SheetContent>
      </Sheet>

      {/* Desktop Sidebar */}
      <div className={cn('hidden lg:flex lg:flex-col lg:w-64 lg:fixed lg:inset-y-0 lg:z-50', className)}>
        <div className="flex h-full flex-col border-r bg-background">
          <div className="flex items-center justify-between p-4 border-b">
            <h1 className="text-xl font-bold">Scholar Bee</h1>
          </div>
          <ScrollArea className="flex-1 p-4">
            <NavItems />
          </ScrollArea>
          <div className="border-t p-4">
            <Button
              variant="ghost"
              className="w-full justify-start"
              onClick={() => {
                // Handle logout
              }}
            >
              <LogOut className="h-4 w-4 mr-2" />
              {t('logout')}
            </Button>
          </div>
        </div>
      </div>
    </>
  )
}
