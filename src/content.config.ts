import { glob } from 'astro/loaders';
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
    loader: glob({ base: './src/content/blog', pattern: '**/*.{md,mdx}' }),
    schema: ({ image }) => z.object({
        title: z.string(),
        description: z.string().optional(),
        pubDate: z.date(),
        updatedDate: z.date().optional(),
        tags: z.array(z.string()).optional(),
        categories: z.array(z.string()).optional(),
        heroImage: image().optional(),
    }),
});

const weeks = defineCollection({
    loader: glob({ base: './src/content/weeks', pattern: '**/*.{md,mdx}' }),
    schema: ({ image }) => z.object({
        title: z.string(),
        description: z.string().optional(),
        pubDate: z.date(),
        updatedDate: z.date().optional(),
        tags: z.array(z.string()).optional(),
        categories: z.array(z.string()).optional(),
        heroImage: image().optional(),
    }),
});

const about = defineCollection({
    loader: glob({ base: './src/content/about', pattern: '**/*.{md,mdx}' }),
});

const home = defineCollection({
    loader: glob({ base: './src/content/home', pattern: '**/*.{md,mdx}' }),
});


export const collections = {
    blog,
    weeks,
    about,
    home,
};