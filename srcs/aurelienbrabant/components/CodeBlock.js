import { Prism as SyntaxHighlighter } from "react-syntax-highlighter";
import { atomDark } from 'react-syntax-highlighter/dist/cjs/styles/prism';

export default function CodeBlock({ language, value }) {
	return (
		<SyntaxHighlighter
			language={language} 
			showLineNumbers
			showInlineLineNumbers
			style={atomDark}
			codeTagProps={{
				style: {
					fontFamily: "JetBrains Mono"
				}
			}}
		>
			{value}
		</SyntaxHighlighter>
	);
}
