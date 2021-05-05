import ReactMarkdown from "react-markdown";
import CodeBlock from "./CodeBlock";
import InlineCode from "./InlineCode";
import Link from "./Link";
import Image from "./Image";
import BlockQuote from "./BlockQuote"

export default function Markdown({ markdownData }) { 
	return (
		<ReactMarkdown
			source={markdownData}
			renderers={{
				code: CodeBlock,
				inlineCode: InlineCode,
				link: Link,
				image: Image,
				blockquote: BlockQuote,
			}}
		/>
	);
}
