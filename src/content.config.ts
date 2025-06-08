import { glob } from 'astro/loaders';
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
	// Load Markdown and MDX files in the `src/content/blog/` directory.
	loader: glob({ base: './src/content/blog', pattern: '**/*.{md,mdx}' }),
	// Type-check frontmatter using a schema
	schema: ({ image }) => z.object({
        title: z.string(),
        description: z.string().optional(),
        // 直接期望一个 Date 类型
        // Astro 的内容集合系统会负责将你的日期字符串解析为 Date 对象
        pubDate: z.date(),
        updatedDate: z.date().optional(),
        tags: z.array(z.string()).optional(),
        categories: z.array(z.string()).optional(),
        heroImage: image().optional(),
    }),
});

export const collections = { blog };
