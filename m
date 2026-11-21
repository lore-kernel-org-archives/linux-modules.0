Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224149;
	b=w0P1z+Mwor8fIDGxgc51QFy+p6VQVeE73S+FJl3xjef7w3sYM0fDhRdMqi5ACpUbgm3O
	 TY5VueJMl5MxAzHUFM1Y3q+kjPdFX3X1n2LdonLuo/U/ym0zzL80TNNeq8jPJCe1bbCkS
	 ONTcicA67c7SiJoIXu+UcvykmWQ9CD2n5lV2tJRlgJxOphpSh0YQe7HP4uwIUOtlsMfMF
	 AC8kpKAm/nqaKxTMOVhdon38ySjzuji2q/MyyZ6OIv/H/MnY/WiRZobk7j22pvXrEUY16
	 3pvri5+1z7VOhgpFXJubBbxS3Nf7pYe7AnP4xoujfKPkCLm+IijnxFnwstSmbefQ47A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224149;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jj9ufaU9aq+HcELA26/VricNQmbSV36azmb5TUev+oE=;
	b=3mAng/n03YrOO/5uU5HtgdPhwmrvdd3vooEvX5OjhhaQLnzhXNAI+3mzqWG1yOU4rhP7
	 ivMwuRjFXfXFMNkgbYOh+WL/KvktpT8b3UptselPvQ5KA5gN94Mq7gVZRNj1dPosYiws5
	 wCbrQ5CMrExiSkGth35AVz9cfeW4yxCkZSBGFQpRbSoHzeZgZZh8auYQ9V67wQ5di2Zoo
	 4ZQ4h43c8FdOB7EqppOpPNGD32oh9bnYNUHe87Qz4vKl+zfnUEVhRzHwlZKrYI7R3qn60
	 nU+WUm+SQxj2owKfYlC1XmLKzhtQ47oBPUPcuPGXizaYlYmUfjkecW/fGAfpVDx5BwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C8Bs8CJA;
	arc=none smtp.remote-ip=91.218.175.178
Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB787606A6A5
	for <linux-modules@vger.kernel.org>; Sat, 21 Nov 2026 01:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB787606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C8Bs8CJA
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GB4Cp/R6VnakhXV0P6BPENiPNWGa3q/lPoUJcR4Uy2I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795224146; v=1; x=1795828946;
 b=C8Bs8CJAhJNhmnKBuPN6HNclpqF3IapE3rBSlstlEGZmbfrt+b2lWnmIn/BpqH8maNw9VlU4
 O26CQzlK6Q74g07vX6typpd3eknlPLLz86X1RPNS1X2L4ntUExijWM+5gHjHDf2pQhVxy3XWRAv
 bTpoQ5eNUuVCPj9VBtLAs7sI=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f3cbd5c8c722fcd7;
	Sat, 21 Nov 2026 01:22:26 +0000
X-Mizu-Trace-ID: f3cbd5c8c722fcd7
X-Migadu-Flow: FLOW_OUT
Date: Sat, 21 Nov 2026 01:22:26 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: petr.pavlu@suse.com
CC: atomlin@atomlin.com, da.gomez@kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, mcgrof@kernel.org, samitolvanen@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_module=3A_Clarify_purpose_and_?=
 =?US-ASCII?Q?description_of_elf=5Fvalidity=5Fcache=5Fcopy=28=29?=
In-Reply-To: <20261119-module-elf-validation-v1-1-69a74a84552c@suse.com>
Message-ID: <A862E988-8886-430B-B32B-901723DA8B05@linux.dev>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 November 2026 16:25:27 GMT, Petr Pavlu <petr.pavlu@suse.com> wrote:
>With the advent of LLM agents, a number of recent patches and bug reports
>for the module loader focus on its validation of module ELF metadata.
>However, many of them are misguided.
>
>Loading a module is a privileged operation. The ELF metadata can normally
>be trusted, just as the module code itself is expected to be correct. The
>checks in elf_validity_cache_copy() are intended to catch accidental
>corruption and basic violations of the ELF format, rather than to provide
>exhaustive validation. The only requirement is that enough of the ELF data
>is validated for the module loader to safely reach the blacklist check
>without crashing on a corrupted module file. This allows a broken module
>to
>be blacklisted and prevented from loading.
>
>Clarify the purpose of elf_validity_cache_copy() and otherwise clean up
>its
>description. Hopefully, LLM agents will take this into account and the
>number of validation-related reports will decrease.
>

thxthx

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


>Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>---
> kernel/module/main.c | 37 +++++++++++++++++++++++--------------
> 1 file changed, 23 insertions(+), 14 deletions(-)
>
>diff --git a/kernel/module/main.c b/kernel/module/main.c
>index 34e0204ea37c..0c204f07ca68 100644
>--- a/kernel/module/main.c
>+++ b/kernel/module/main.c
>@@ -2421,24 +2421,33 @@ static int elf_validity_cache_strtab(struct load_info *info)
> }
> 
> /*
>- * Check userspace passed ELF module against our expectations, and cache
>- * useful variables for further processing as we go.
>+ * Check the ELF module passed in from userspace against our expectations, and
>+ * cache useful variables for further processing as we go.
>  *
>- * This does basic validity checks against section offsets and sizes, the
>- * section name string table, and the indices used for it (sh_name).
>+ * Loading a module is a privileged operation. The ELF metadata can normally be
>+ * trusted, just as the module code itself is expected to be correct. These
>+ * checks are intended to catch accidental corruption and basic violations of
>+ * the ELF format, rather than to provide exhaustive validation. The only
>+ * requirement is that enough of the ELF data is validated for the module loader
>+ * to safely reach the blacklist check without crashing on a corrupted module
>+ * file. This allows a broken module to be blacklisted and prevented from
>+ * loading.
>  *
>- * As a last step, since we're already checking the ELF sections we cache
>- * useful variables which will be used later for our convenience:
>+ * The checks cover the ELF header, section offsets and sizes, section-name and
>+ * symbol string tables, offsets into those tables, and selected
>+ * section-specific constraints.
>  *
>- * 	o pointers to section headers
>- * 	o cache the modinfo symbol section
>- * 	o cache the string symbol section
>- * 	o cache the module section
>+ * While validating, cache the following for later use:
>  *
>- * As a last step we set info->mod to the temporary copy of the module in
>- * info->hdr. The final one will be allocated in move_module(). Any
>- * modifications we make to our copy of the module will be carried over
>- * to the final minted module.
>+ * * pointers to the section headers and section-name string table
>+ * * indices of relevant sections, including .modinfo, the symbol table, the
>+ *   symbol string table, the module section, and version sections
>+ * * a pointer to the symbol string table
>+ *
>+ * Finally, set info->mod to point to the temporary module struct within
>+ * info->hdr. The final copy of the module struct will be allocated in
>+ * move_module(). Any modifications to the temporary copy will be carried over
>+ * to the final one.
>  */
> static int elf_validity_cache_copy(struct load_info *info, int flags)
> {
>
>---
>base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
>change-id: 20261119-module-elf-validation-a5a0e28e6dcb
>
>

--- Thanks!
