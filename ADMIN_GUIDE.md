# Circular Horizons CMS - Admin Guide

## Getting Started

### Admin Login
1. Visit `/admin/login` to access the admin panel
2. Use your Supabase admin credentials to log in
3. After successful login, you'll be redirected to the dashboard

## Dashboard Overview

The admin dashboard provides quick access to:
- Total pages count
- Published news articles count
- Media library files count
- Unread contact form submissions

## Managing Site Settings

Navigate to **Site Settings** to manage:

### General Settings
- **Site Title**: Your website name
- **Site Description**: Brief description of your site

### SEO Settings
- **Meta Title**: Default page title for SEO
- **Meta Description**: Default meta description
- **Meta Keywords**: Comma-separated keywords

### Logos & Branding
- **Header Logo URL**: Logo displayed in navigation
- **Footer Logo URL**: Logo displayed in footer
- **Favicon URL**: Browser tab icon (PNG format recommended)

### Contact Information
- **Email Address**: Contact email displayed on site
- **Phone Number**: Contact phone number
- **Address**: Full physical address (supports multi-line)

### Social Media Links
- **LinkedIn**: Full LinkedIn profile/company URL
- **Twitter**: Full Twitter profile URL
- **Facebook**: Full Facebook page URL

### Footer
- **Copyright Text**: Custom footer copyright text

## Managing Pages

Navigate to **Pages** to edit static pages:

1. Select a page from the list
2. Edit the following:
   - **Title**: Page title
   - **Content**: HTML content for the page
   - **Published**: Toggle page visibility
   - **Meta Title**: SEO title
   - **Meta Description**: SEO description
   - **Meta Keywords**: SEO keywords

3. Click **Save Page** to update
4. Use **Preview** to view the page before saving

### Available Pages
- About (about)
- Privacy Policy (privacy)
- Terms of Service (terms)
- Cookie Policy (cookie)
- Consultancy (consultancy)
- Green Registry (green-registry)
- ESG Report (esg-report)
- Mizan ESG (mizan-esg)
- Careers (careers)
- FAQ (faq)

## Managing News Articles

### Creating News Articles
1. Navigate to **News Articles**
2. Click **Create New Article**
3. Fill in the form:
   - **Title**: Article title (auto-generates slug)
   - **Slug**: URL-friendly identifier
   - **Excerpt**: Short summary for listings
   - **Featured Image URL**: Main article image
   - **Content**: Full HTML article content
   - **Published**: Toggle to publish/unpublish
   - **Meta Title**: SEO title
   - **Meta Description**: SEO description

4. Click **Save Article**

### Editing News Articles
1. Click on an article from the list
2. Make your changes
3. Click **Save Article**

### News Display
- Homepage shows latest 3 articles
- News index page shows 12 articles per page with pagination
- Each article page shows related articles at the bottom

## Media Library

### Adding Media
1. Navigate to **Media Library**
2. Enter media details:
   - **File URL**: Direct URL to your image
   - **Filename**: Descriptive filename
   - **Alt Text**: Accessibility description

3. Click **Add Media**

### Using Media
- Click on any media URL to copy it
- Paste the URL into Featured Image fields or content

### Tips
- Use high-quality images from Pexels or similar services
- Recommended image sizes:
  - Featured images: 1200x630px
  - Logos: 200x50px (transparent PNG)
  - Favicon: 32x32px or 64x64px PNG

## Contact Form Submissions

Navigate to **Contact Forms** to:
- View all form submissions
- Click on a submission to read the full message
- Messages are automatically marked as "Read" when opened

## Best Practices

### SEO Optimization
1. Always fill in meta titles and descriptions
2. Use descriptive, keyword-rich content
3. Keep meta descriptions under 160 characters
4. Use unique meta titles for each page/article

### Content Guidelines
1. Write in HTML for rich formatting
2. Use semantic HTML tags (h1, h2, p, ul, etc.)
3. Include internal links between pages
4. Optimize images before upload
5. Test on mobile devices

### News Articles
1. Publish regularly for better SEO
2. Use high-quality featured images
3. Write compelling excerpts (under 200 characters)
4. Include relevant keywords naturally
5. Link to related articles and pages

### Media Management
1. Organize media files with clear filenames
2. Always add alt text for accessibility
3. Use appropriate image formats (PNG for logos, JPG for photos)
4. Consider image file sizes for performance

## Mobile Responsiveness

All pages are fully responsive and optimized for:
- Desktop (1280px+)
- Tablet (768px - 1279px)
- Mobile (320px - 767px)

Always preview changes on multiple devices.

## Security Notes

1. Never share your admin credentials
2. Use strong passwords
3. Log out when finished
4. Only upload images from trusted sources
5. Be careful with HTML content to avoid security issues

## Support

For technical issues or questions:
- Check database connection in `.env` file
- Verify Supabase credentials
- Review browser console for errors
- Contact development team for assistance
