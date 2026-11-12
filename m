Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456847;
	b=R51i723Q5Mc68LJ8lAGln9wbxQhb2KQEwG9OuWA2Iuhrjc030Rpl+bsP8WlXY6VMbvs2
	 7UaH8TeHguNsBID+Wk7DNFHUCgjCWEj7Q8g2sKQOu3RPj0GfY/AsdFvBp0J4zr0lv5RJj
	 duIGT+Z7KI1ktTWePzNGUkUsSfU8/YKco6CnXsYJTQhPytpnJTGcyIwjSjUFeciHao9B3
	 Do1mfdcUWJOLozS79rOYcYVBEUJT9n3rfyhapOd9PDmndkf5xj3mCy5I59UV7tkGsKltb
	 pDwkIhqvP898bBK8QLgzGPLh04yoPONt/0bOQgEwMn0q9BLblmvb67fzk8gOBaGNQ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456847;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iXAKJg6zY8C69aDtcGRnNYHf2kCXmrJS3Va5RrXUFX4=;
	b=CAbNsCdrnC5fOSiHOtiJy3vMK4QwGpQsxZLEUvfYsxkS2a8w6Tm6wgUJmxDLIeXCAByG
	 O5AGRw7np/BZ76NUfbp+UT5l2t5GD6JexW19/UdD/8Pe2iKWArp/aLoncyFoqYXM0+X0C
	 a76GW85QUKw0CDrdlrigNvRRBEgKpXpSyMt2S6yOS0KC24s6/k5LUyQemrI61IVITSD5N
	 P8bmCtJn0XBQV0lAbquCbXWB57HHvLEICM0M4X57R4iB6dDMZw8747u+IKCMDmMOLfo/4
	 HixmbV7BO3hxfWuZGsRbpG1kMJxTnsPb5mNWi8dZWg34kcHBISL7kQZGHplhbAXO/JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyWvZOdo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14706606A324;
	Thu, 12 Nov 2026 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WyWvZOdo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458B01F00A09;
	Thu, 12 Nov 2026 04:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456846;
	bh=iXAKJg6zY8C69aDtcGRnNYHf2kCXmrJS3Va5RrXUFX4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=WyWvZOdol6x93YWimGT86hig5kEHkq5TgpTl5onS4zyWVexgrE/0rmrzJ+OHaXGH+
	 4j2Wx4Bc7rJgrnT81iXeQiS2PS2JwnnPpZsH6bLgAGQVjGSKb2bLF2ToEwMOW2R39f
	 +I7nC4J5ajm/wFAy24DTjbz267eM9rnvhWqauYSMdY6IMbKH70WSZPQWVdoZQT9alK
	 3dJ5r4Wb5r9Ww+vY5pA4gA0A9mcJ3BbVNZT3xeR+lAyx9U0Guq7Ongu1nt671VGSan
	 vQ4Y5+LVJrV9TMAhpPPv7p4qaL3ioP4mYHSnMN3r808IndKb/feSD+2pVHdM4Mamx3
	 yrd0dlYh1T2Nw==
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 04/11] modpost: emit module descriptors as assembly
From: Nathan Chancellor <nathan@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
In-Reply-To: <20261104-build-speedup-v5-4-0f6018be8dae@kernel.org>
References: <20261104-build-speedup-v5-0-0f6018be8dae@kernel.org>
 <20261104-build-speedup-v5-4-0f6018be8dae@kernel.org>
Date: Wed, 11 Nov 2026 21:13:34 -0700
Message-Id: <179445681471.2545603.9087503756678100323.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=710; i=nathan@kernel.org;
 h=from:subject:message-id; bh=5zOPsgG3qRcAwVUzP38XzV+fFPN5BZsO2d/rW710CK0=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlfbT7pznaediB1btKxC0IvMuNbG8qa3sZ9qc59bPtlx
 7NZQUJLO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBE9DkZGZbMLdqg55W47cGm
 IyHP0+UqG4zUZSZd/uB0n7Xmw4OP000ZGU5+mKXDPE9mQXM3k828Xbzsb97b7TI0Sxb7tviW2Tc
 mK3YA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Wed, 04 Nov 2026 18:20:22 +0000, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> modpost generates a descriptor for every module in the form of a
> <module>.mod.c file with .modinfo strings, the __this_module descriptor,
> exported symbol tables and (with CONFIG_MODVERSIONS set), the CRC of
> imported symbols.
> 
> These files are compiled like any other kernel C file with all of the
> -include preamble, as well as including linux/module.h, header dependencies
> generated by fixdep of a few hundred headers, an objtool run and if LTO is
> being performed, a link is performed to generate native code.
> 
> [...]

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan

