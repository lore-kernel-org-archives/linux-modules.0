Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522880;
	b=vVwAhnEJZq/1lYpfeuNeGi/iPT1IW7VDfoKz0UrAsUxZ0fZzGdSCfNniH0h8v6Qkhk6+
	 /mcrrQENSCD2UcgJ4vLJjdimKeGqqtrkfRzlzpQHPOuaq3ntG1zN7xvZgi65T/Hm5Ygkd
	 imP2aEMAYX8rJ2AKFjF8pjxnzNClo8ZPIEZNhjNi3QNfCipLlWrOkFPjCPZo45Gusi0ze
	 PRd1A3hUOev+tKG5pgMl+6dtFQ5nQ1lOE36AkCWz9uI0EkyOl8fGOK+jCbQ7W5ZTxGBcq
	 8IsQuVz+xNV5fsCGDIrPS9fQYEOeuFn6jWTrB7NQzINsUk8OkL+mOEcNaBsXrk8h1TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522880;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Xbx0lkyEH1jdcxoxNWiUBHwzx5Nfc6UsYeAtIegNYWU=;
	b=TVYcqQuY6KG4oYRa7ZA2UBhO79T3ftKiQ5dDH/7M5XbCJ4/V0Ldmr0oGU1/iYDw2+1Uu
	 MnqfJsW0gOYWGIsPHWz7nGNloyhLAwVrH60Ng+pkk9PEU8jftOkK7dyCGtszhm5GJcxMz
	 C3OOE+QKwIbQXvUKr2V1LKGbyR5Un89zshBmNmvjWvsv3Md06R4/sJerhTv/fQRynt0uq
	 Fwalti5ARug3hwQ+lvXYHOoUmwpHU3S8BcVHUOlT0Axiwi75qp2XffoUD04QwcSc61om2
	 D85XAO61pTapYvfAm/K+et6/s/50RYzOg03kFH5DNKUcwzphlrJFCsWJeyQN9kSd6SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCfPVofO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F82606A31E;
	Tue, 24 Nov 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCfPVofO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92B01F000D8;
	Tue, 24 Nov 2026 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522879;
	bh=Xbx0lkyEH1jdcxoxNWiUBHwzx5Nfc6UsYeAtIegNYWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oCfPVofOR7AyS5BgzpJPI6ZqzVkNhjF6heECkK614Qdu12AGmAYvkmO4citmEYUrL
	 YKQRVDD/iEuviAPdHU9P7ZfI41qR3nSZdPZ2aSyrLIR2bLTBRyXFU8jmJHSL3gTVvI
	 JNnv2bnBscguIwc4ojDIzcnmO6RSgqlGiQ/SV71kPGO7ORCI6Ojb63uilcdbu34ALD
	 BIb4cRMV2+FkzaxZUkMy6mP21RP/BY7hRtLeej6onklOYYpM2ovQ2EgsJhz6Bq/iOi
	 eLIfj89/PuxOaPQxRuma3+1moTgXHJGMTRhpOaXYKrBqEd+xp/TSb66aeZZpHvyB64
	 Yy4pTn7E7F6+g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 12:20:16 +0000
Subject: [PATCH v6 6/7] rust: make exports.o depend on the headers
 generated for it
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
Message-Id: <20261124-build-speedup-v6-6-141a4f861c67@kernel.org>
References: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
In-Reply-To: <20261124-build-speedup-v6-0-141a4f861c67@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
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
 Nicolas Schier <n.schier@fritz.com>, Kees Cook <kees@kernel.org>
Cc: ljs@kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=ljs@kernel.org;
 h=from:subject:message-id; bh=19Xc0y+KWUOL2pPe/Y3BojjXrN9DHW/cJgclSTiky2k=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZG/5LG4Q9KBQ385rM0lab5v7uzNROi6K8DXIZ3LGvF
 0T8fiTaUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgImEsTIydC7u8gsyCfr5ht2p
 dy97FBeT0s/LjtflDjzr/pd2VWlyPyPDlTfPtilnWbAZCAo6iOf7ixhv9GE0nmcRvU0vVVT39Xd
 uAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

rust/exports.c includes the exports_*_generated.h listing the symbols of
the core, bindings, kernel and helpers objects, but this is not expressed
in its Makefile.

This worked previously because the headers are always-y targets, and make
prepare built all of the rust crates first, which is an implicit
dependency.

Fix this as it is a dependency of the subsequent commit.

Reviewed-by: Nicolas Schier <n.schier@fritz.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 rust/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index 0ac9ab28cc2b..cee016cd8d32 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -728,6 +728,11 @@ endef
 $(obj)/helpers/helpers.o: $(src)/helpers/helpers.c $(recordmcount_source) FORCE
 	+$(call if_changed_rule,rust_cc_library)
 
+# The exported symbol lists are generated from the crates' objects.
+$(obj)/exports.o: $(obj)/exports_core_generated.h \
+    $(obj)/exports_bindings_generated.h $(obj)/exports_kernel_generated.h \
+    $(if $(CONFIG_RUST_INLINE_HELPERS),,$(obj)/exports_helpers_generated.h)
+
 # Disable symbol versioning for exports.o to avoid conflicts with the actual
 # symbol versions generated from Rust objects.
 $(obj)/exports.o: private skip_gendwarfksyms = 1

-- 
2.56.1

