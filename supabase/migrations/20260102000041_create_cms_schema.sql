/*
  # Create CMS Schema

  1. New Tables
    - `site_settings`
      - `id` (uuid, primary key)
      - `key` (text, unique) - setting identifier
      - `value` (text) - setting value
      - `type` (text) - data type (text, json, image)
      - `updated_at` (timestamptz)
    
    - `pages`
      - `id` (uuid, primary key)
      - `slug` (text, unique)
      - `title` (text)
      - `content` (text) - HTML content
      - `meta_title` (text)
      - `meta_description` (text)
      - `meta_keywords` (text)
      - `is_published` (boolean)
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
    
    - `news_articles`
      - `id` (uuid, primary key)
      - `slug` (text, unique)
      - `title` (text)
      - `excerpt` (text)
      - `content` (text) - HTML content
      - `featured_image` (text)
      - `meta_title` (text)
      - `meta_description` (text)
      - `meta_keywords` (text)
      - `is_published` (boolean)
      - `published_at` (timestamptz)
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
    
    - `media`
      - `id` (uuid, primary key)
      - `filename` (text)
      - `url` (text)
      - `alt_text` (text)
      - `file_size` (integer)
      - `mime_type` (text)
      - `created_at` (timestamptz)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated admin users
*/

-- Create site_settings table
CREATE TABLE IF NOT EXISTS site_settings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  key text UNIQUE NOT NULL,
  value text,
  type text DEFAULT 'text',
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access to site_settings"
  ON site_settings FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE POLICY "Allow authenticated users to update site_settings"
  ON site_settings FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow authenticated users to insert site_settings"
  ON site_settings FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Create pages table
CREATE TABLE IF NOT EXISTS pages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  title text NOT NULL,
  content text DEFAULT '',
  meta_title text,
  meta_description text,
  meta_keywords text,
  is_published boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE pages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access to published pages"
  ON pages FOR SELECT
  TO anon, authenticated
  USING (is_published = true);

CREATE POLICY "Allow authenticated users full access to pages"
  ON pages FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create news_articles table
CREATE TABLE IF NOT EXISTS news_articles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  title text NOT NULL,
  excerpt text DEFAULT '',
  content text DEFAULT '',
  featured_image text,
  meta_title text,
  meta_description text,
  meta_keywords text,
  is_published boolean DEFAULT false,
  published_at timestamptz,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE news_articles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access to published news"
  ON news_articles FOR SELECT
  TO anon, authenticated
  USING (is_published = true);

CREATE POLICY "Allow authenticated users full access to news"
  ON news_articles FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Create media table
CREATE TABLE IF NOT EXISTS media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  filename text NOT NULL,
  url text NOT NULL,
  alt_text text DEFAULT '',
  file_size integer DEFAULT 0,
  mime_type text DEFAULT 'image/png',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE media ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access to media"
  ON media FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE POLICY "Allow authenticated users full access to media"
  ON media FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Insert default site settings
INSERT INTO site_settings (key, value, type) VALUES
  ('site_title', 'Circular Horizons', 'text'),
  ('site_description', 'Pioneering sustainable solutions for a circular economy future', 'text'),
  ('header_logo', '', 'image'),
  ('footer_logo', '', 'image'),
  ('favicon', '', 'image'),
  ('meta_title', 'Circular Horizons International - Sustainable Solutions', 'text'),
  ('meta_description', 'Pioneering sustainable solutions for a circular economy future. We help businesses transition to sustainable practices.', 'text'),
  ('meta_keywords', 'sustainability, circular economy, ESG, consultancy', 'text'),
  ('contact_email', 'info@circularhorizons.com', 'text'),
  ('contact_phone', '+44 (0) 20 1234 5678', 'text'),
  ('contact_address', '123 Sustainability Street, London, UK, EC1A 1BB', 'text'),
  ('social_linkedin', '', 'text'),
  ('social_twitter', '', 'text'),
  ('social_facebook', '', 'text'),
  ('footer_copyright', '© 2026 Circular Horizons. All rights reserved.', 'text')
ON CONFLICT (key) DO NOTHING;

-- Insert default pages
INSERT INTO pages (slug, title, content, is_published) VALUES
  ('about', 'About Us', '<h1>About Circular Horizons</h1><p>Content to be added...</p>', true),
  ('privacy', 'Privacy Policy', '<h1>Privacy Policy</h1><p>Content to be added...</p>', true),
  ('terms', 'Terms of Service', '<h1>Terms of Service</h1><p>Content to be added...</p>', true),
  ('cookie', 'Cookie Policy', '<h1>Cookie Policy</h1><p>Content to be added...</p>', true),
  ('consultancy', 'Consultancy Services', '<h1>Consultancy Services</h1><p>Content to be added...</p>', true),
  ('green-registry', 'Green Registry', '<h1>Green Registry</h1><p>Content to be added...</p>', true),
  ('esg-report', 'ESG Reporting', '<h1>ESG Reporting</h1><p>Content to be added...</p>', true),
  ('mizan-esg', 'Mizan ESG', '<h1>Mizan ESG</h1><p>Content to be added...</p>', true)
ON CONFLICT (slug) DO NOTHING;
