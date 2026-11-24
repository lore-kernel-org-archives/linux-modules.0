Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522853;
	b=LrSlAeeoxzNjG+91L9sWzSzyZSr/vkVrzBDBCh7fcgYC4BJuo90KVpcsqO9rBJ4xzrkZ
	 KgNiV44A9bhF02dKfDN87EOtzuM9d/Iodkphc7K17k4g03fWt+JdvKv2GrLo1KC3l3k29
	 j93x9hsulNK2c0dAGQ98GHOZksI7CGHwNYMR5FlkFkCX2JdzMc3qV3k3TpK7Y+wer1U1C
	 piUjyuzxBEpQnZ9+d8gMSXQ31vNYPHPvztreTqaLPWAgMAy8+CzWloFzk1XRit+Ds0PQ7
	 g63qkY6UGHGFjw4/32UUxEKt0lfnwNjhQa6h2rre8uMi+5Eo5lP89uQCDGX0cZrbMag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522853;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZP09cJJ7Neg9l9E7oLMhKK0hSsVRBZKgmC7uGgdqlf0=;
	b=TjDIK6FTJCCSt9TVIQpIM467tkVndwvbxssr96/WcoP4ycIoa+tuiMGqNHJGInEA1a4A
	 5rENKZI3jSJLRUh1YG6aRlGCPkm86i4jla5Xxcf1OHuMM56cgmnapqPYz0+lQRUyMeCPT
	 oOuasbZXDp0S1vhAM7B5QEJU4TK3xO+XGsKaPDlHauryxK1tcw7l2oyMkzsnI2yUlQRbW
	 TVgIlqpoBEErvHc1t5199CBuQjUWxC/irNv9Ns0Bf/igfPS9NAyyCvI7Rp1nt2edAE8Mv
	 qzv/WeajjSplF0LaeC9fT+58zqAoHXkvEMikPdc2aJ7Yd5gX4Cb7kgpslK3tgCHM8lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPMhWXHL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157D4606A32A;
	Tue, 24 Nov 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPMhWXHL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7461F000CA;
	Tue, 24 Nov 2026 12:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522852;
	bh=ZP09cJJ7Neg9l9E7oLMhKK0hSsVRBZKgmC7uGgdqlf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oPMhWXHLiQrYiG9KpQPyAM4zFTMRdNHE5CpqWvafbs8dFIooBF7dNgNpK/2Ld+gx5
	 ysX//HO9+m4c/lpz0TKYaWvtr31jIl1u/NPSXJmj/TzkVD1ceZhno6xocfGOeitAiI
	 HG023CQrA7endQrZtsOZlW4tjkK0iq9ZJ5vBfGi1BOIYuOUUUIPKXO7ovxHtGG5D+n
	 WRxVKobR/1gaHpXnaHlI8OerOhT1LwBTrO1WtvPS3msA1c4JQpKuTG9MVgaOWLwCl5
	 N+G3ZViU9Stn0UUOQSGlIRj4N5lz7lMBhcnv7eqNaD3tV+N9v0JSDRpMyyPESC7KhF
	 echX1F/tQd5BA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 12:20:13 +0000
Subject: [PATCH v6 3/7] modpost: cache section relocation mismatch state
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
Message-Id: <20261124-build-speedup-v6-3-141a4f861c67@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5319; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Ajc/OoizwiHScfekejDmAwGblxllbCBCdPy2ke1V4EA=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZG/7dvOC0PtPVhLcwP09vm++cNeUWD8837a/ZmucRs
 pjXq+JrRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACayNorhv/fTO9ynF7TrLn0h
 F5PhYhjn6tbp6HA5NeXmuqXcehWGhxgZvt40P8ehyrNhGtNW06laqraP1ircDNixa1JC02/Pozv
 nsAMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

For every relocation modpost invokes check_section_mismatch() to determine
whether there is any kind of mismatch between the source and destination,
and if so which classification applies.

Each time it does this it invokes section_mismatch() which iterates
through the sectioncheck[] array every time it's called.

When walked a relocation section the source is fixed and there aren't many
targets, so the same names are looked up over and over again.

Therefore cache not only mismatch categorisation but also whether a
mismatch even exists for a given section and look up the sections in the
cache.

Special indices (undefined, absolute, common) take the uncached path as
before.

This results in very significant speed ups for allmodconfig incremental
builds.

modpost is on the serial tail of every build that links vmlinux.

Whole build, 128-thread Threadripper 9980X, best of N runs:

                                         before   after     delta
                                         -------------------------------
  x86 defconfig, touch mm/vma.c, gcc        8.5s     8.3s    -0.14s (-2%)
  x86 defconfig, touch mm/vma.c, clang      7.7s     7.6s    -0.13s (-2%)
  x86 allmodconfig, touch mm/vma.c, gcc    33.9s    29.4s     -4.5s (-13%)
  x86 allmodconfig, touch mm/vma.c, clang  31.9s    27.9s     -4.0s (-13%)

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 scripts/mod/modpost.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++--
 scripts/mod/modpost.h |  8 +++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 75374c64b8cc..83caf29b4bf2 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1155,12 +1155,62 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 			 name);
 }
 
+static void init_mismatch_cache(struct elf_info *elf)
+{
+	elf->mismatch_cache = xcalloc(elf->num_sections,
+				      sizeof(*elf->mismatch_cache));
+}
+
+static void reset_mismatch_cache(struct elf_info *elf)
+{
+	memset(elf->mismatch_cache, 0,
+	       elf->num_sections * sizeof(*elf->mismatch_cache));
+}
+
+static void free_mismatch_cache(struct elf_info *elf)
+{
+	free(elf->mismatch_cache);
+	elf->mismatch_cache = NULL;
+}
+
+static const struct sectioncheck
+*cache_mismatch(const struct elf_info *elf, unsigned int to_secndx,
+		const struct sectioncheck *mismatch)
+{
+	if (!mismatch) {
+		elf->mismatch_cache[to_secndx] = -1;
+		return NULL;
+	}
+
+	elf->mismatch_cache[to_secndx] = (mismatch - sectioncheck) + 1;
+	return mismatch;
+}
+
+static const struct sectioncheck *get_section_mismatch(const struct elf_info *elf,
+		const char *fromsec, unsigned int to_secndx)
+{
+	int cached;
+
+	if (to_secndx >= elf->num_sections)
+		return section_mismatch(fromsec, sec_name(elf, to_secndx));
+
+	cached = elf->mismatch_cache[to_secndx];
+	if (cached < 0)
+		return NULL;
+	if (cached > 0)
+		return &sectioncheck[cached - 1];
+
+	return cache_mismatch(elf, to_secndx,
+			      section_mismatch(fromsec, sec_name(elf, to_secndx)));
+}
+
 static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 				   Elf_Sym *sym,
 				   unsigned int fsecndx, const char *fromsec,
 				   Elf_Addr faddr, Elf_Addr taddr)
 {
-	const char *tosec = sec_name(elf, get_secindex(elf, sym));
+	unsigned int to_secndx = get_secindex(elf, sym);
+	const char *tosec = sec_name(elf, to_secndx);
 	const struct sectioncheck *mismatch;
 
 	if (module_enabled && elf->export_symbol_secndx == fsecndx) {
@@ -1168,7 +1218,7 @@ static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 		return;
 	}
 
-	mismatch = section_mismatch(fromsec, tosec);
+	mismatch = get_section_mismatch(elf, fromsec, to_secndx);
 	if (!mismatch)
 		return;
 
@@ -1445,6 +1495,8 @@ static void check_sec_ref(struct module *mod, struct elf_info *elf)
 {
 	int i;
 
+	init_mismatch_cache(elf);
+
 	/* Walk through all sections */
 	for (i = 0; i < elf->num_sections; i++) {
 		Elf_Shdr *sechdr = &elf->sechdrs[i];
@@ -1461,6 +1513,9 @@ static void check_sec_ref(struct module *mod, struct elf_info *elf)
 			if (match(secname, section_white_list))
 				continue;
 
+			/* Reset cache per-section. */
+			reset_mismatch_cache(elf);
+
 			start = sym_get_data_by_offset(elf, i, 0);
 			stop = start + sechdr->sh_size;
 
@@ -1472,6 +1527,8 @@ static void check_sec_ref(struct module *mod, struct elf_info *elf)
 					    start, stop);
 		}
 	}
+
+	free_mismatch_cache(elf);
 }
 
 static char *remove_dot(char *s)
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 666beca685e4..7ba64fd894ef 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -160,6 +160,14 @@ struct elf_info {
 	Elf32_Word   *symtab_shndx_stop;
 
 	struct symsearch *symsearch;
+
+	/*
+	 * Section mismatch cache, indexed by destination section:
+	 *   0 - uncached.
+	 *  -1 - no mismatch.
+	 *  >0 - mismatch index + 1.
+	 */
+	int *mismatch_cache;
 };
 
 /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */

-- 
2.56.1

