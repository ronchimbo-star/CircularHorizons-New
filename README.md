# Circular Horizons International CMS

A modern, full-featured content management system for Circular Horizons International - a pioneering sustainability consultancy.

## Features

### Frontend
- **Dynamic Pages**: All content managed through admin panel
- **News System**: Full blog/news system with pagination
- **Contact Form**: Working contact form with submissions stored in database
- **SEO Optimized**: Meta tags, descriptions, and keywords for all pages
- **Fully Responsive**: Mobile-first design for all devices
- **Service Pages**: Dedicated pages for all services

### Admin Panel
- **Dashboard**: Overview of site statistics
- **Site Settings**: Manage logos, SEO, contact info, and social links
- **Page Editor**: Edit all static pages with HTML content
- **News Management**: Create, edit, and publish news articles
- **Media Library**: Upload and manage images
- **Contact Forms**: View and manage form submissions
- **Secure Authentication**: Supabase-powered admin authentication

## Technology Stack

- **Astro** - Modern static site generator with SSR
- **React** - Interactive components
- **Tailwind CSS** - Utility-first styling
- **Supabase** - Database and authentication
- **TypeScript** - Type-safe development

## Getting Started

### Prerequisites
- Node.js 18+ installed
- Supabase account and project

### Installation

```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build
```

### Environment Variables

The `.env` file is already configured with Supabase credentials.

### Database Setup

The database schema is automatically created with Supabase migrations. The following tables are included:

- `site_settings` - Site configuration and settings
- `pages` - Static page content
- `news_articles` - Blog/news articles
- `media` - Media library
- `contact_submissions` - Contact form entries

## Admin Access

1. Create an admin user in Supabase Authentication
2. Visit `/admin/login` to access the admin panel
3. Use your Supabase credentials to log in

For detailed admin instructions, see [ADMIN_GUIDE.md](./ADMIN_GUIDE.md)

## Project Structure

```
/
├── public/              # Static assets
├── src/
│   ├── components/      # Reusable components
│   │   ├── admin/       # Admin panel components
│   │   ├── sections/    # Homepage sections
│   │   ├── DynamicNavbar.astro
│   │   ├── DynamicFooter.astro
│   │   └── ContactForm.tsx
│   ├── layouts/         # Page layouts
│   │   ├── Layout.astro        # Main site layout
│   │   └── AdminLayout.astro   # Admin panel layout
│   ├── pages/           # Routes
│   │   ├── admin/       # Admin panel pages
│   │   ├── api/         # API endpoints
│   │   ├── news/        # News system pages
│   │   ├── index.astro  # Homepage
│   │   ├── contact.astro
│   │   └── [slug].astro # Dynamic pages
│   ├── lib/             # Utilities
│   │   └── supabase.ts  # Supabase client
│   └── styles/          # Global styles
└── package.json
```

## Key Features

### Dynamic Content
All pages fetch content from the Supabase database, allowing real-time updates without redeployment.

### Responsive Design
- Mobile-first approach
- Breakpoints: 640px (sm), 768px (md), 1024px (lg), 1280px (xl)
- All admin interfaces are mobile-responsive

### News System
- Pagination (12 articles per page)
- Related articles functionality
- Featured images
- SEO meta tags per article
- Draft/published status

### Media Library
- Easy URL copying
- Alt text support
- Organization by filename

### Contact Form
- Client-side validation
- API endpoint for submissions
- Admin dashboard to view submissions
- Read/unread status tracking

## Pages

### Public Pages
- `/` - Homepage with service sections
- `/about` - About us (dynamic)
- `/consultancy` - Consultancy services (dynamic)
- `/green-registry` - Green Registry info (dynamic)
- `/esg-report` - ESG Reporting info (dynamic)
- `/mizan-esg` - Mizan ESG info (dynamic)
- `/news` - News listing with pagination
- `/news/[slug]` - Individual news articles
- `/contact` - Contact page with working form
- `/privacy` - Privacy policy (dynamic)
- `/terms` - Terms of service (dynamic)
- `/cookie` - Cookie policy (dynamic)
- `/careers` - Careers page (dynamic)
- `/faq` - FAQ page (dynamic)

### Admin Pages
- `/admin/login` - Admin authentication
- `/admin/dashboard` - Admin dashboard
- `/admin/settings` - Site settings management
- `/admin/pages` - Page content editor
- `/admin/news` - News article management
- `/admin/media` - Media library
- `/admin/contacts` - Contact form submissions

## Development

```bash
npm run dev
```

The site will be available at `http://localhost:4321`

## Security

- Row Level Security (RLS) enabled on all Supabase tables
- Admin-only write access to content
- Public read access to published content only
- Secure authentication via Supabase Auth

---

Built with Astro, React, Tailwind CSS, and Supabase.
