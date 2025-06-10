Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC623AE83
	for <linux-modules@vger.kernel.org>; Tue, 10 Jun 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573213; cv=none; b=rbPe+phfd6lD8bSOJtSaR6gz/7rCBBnXoBBfJSLJkeN604y0pDrvgfjhnQsOHfPQ6oV/j1C4XanOGwNwz9BQp6FGzhcU+6VCqbOpLunGOOnnGWS9xgiaGcXGRPNQ0gaSrKB7AywUIlHvNaWS4iswnStnlocOYCMyjJwqjoXkeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573213; c=relaxed/simple;
	bh=g3TNmXww8cBEJF1oOMz1epvTxpOGSQWOftZvwN/TNT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bI808BmMdFS8AwGmAHm27DGos5irh8TPK7VJxXEuTsCj9nn0S5c5C6HAVVHMmGSZYoYw6NigE54E2ZZxh3gJGB1DCs7CPmFppCI83261zHHXuFHXBzXI1zS5SvjKDlPssIupQiPG2J2GgiqALQwi6w2hmEsM3U8humrRHCKkTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UX9YyulD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJX5HMWP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UX9YyulD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJX5HMWP"
Date: Tue, 10 Jun 2025 18:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749573209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZnCSYmDm63EgTgy4wiT9gZ6ewenn5vKtM65WhtlV+84=;
	b=UX9YyulDweOZGzSGULQPqY4P1MwyS9+7BHVxVkEUR5bosa+o+RDLEPf+rLvINcxVgdDUPR
	u5/RXA/3Bg/+Vuw44s2jyxC1nNb/GiZxxuEFbereMhc9Q8MD5xlTDqG8vsMfL2MTS5VqpC
	NtKjHMsr6MJQsRpzO+3NvGM6aWU/0w3KQ3MGZpOuyylW9z+8vK6S0qzI671YeLrf5IS9RD
	mqiWS5NfofqUK/JWUqmzy0gGVLrm73+ceTfh6pcBpvTwphG2umJe+NkSkVDMYLsY+PJMsK
	/3TLfaLTF1W3ogULRpNTITv6GQj0xyGJ6sDBTiWCLbZ1CWwnSWvyPzdbjXbIxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749573209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZnCSYmDm63EgTgy4wiT9gZ6ewenn5vKtM65WhtlV+84=;
	b=eJX5HMWPaQGO8S3knGPfZ3WQOaEJ0cgYONVvjk5iDBurIuUxI8WCcREe+Kj0oKGp8nFf6d
	YkNkjn7CMif+amCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-modules@vger.kernel.org
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] module: Make sure relocations are applied to the per-CPU
 section
Message-ID: <20250610163328.URcsSUC1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The per-CPU data section is handled differently than the other sections.
The memory allocations requires a special __percpu pointer and then the
section is copied into the view of each CPU. Therefore the SHF_ALLOC
flag is removed to ensure move_module() skips it.

Later, relocations are applied and apply_relocations() skips sections
without SHF_ALLOC because they have not been copied. This also skips the
per-CPU data section.
The missing relocations result in a NULL pointer on x86-64 and very
small values on x86-32. This results in a crash because it is not
skipped like NULL pointer would and can't be dereferenced.

Such an assignment happens during static per-CPU lock initialisation
with lockdep enabled.

Allow relocation processing for the per-CPU section even if SHF_ALLOC is
missing.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202506041623.e45e4f7d-lkp@intel.com
Fixes: 1a6100caae425 ("Don't relocate non-allocated regions in modules.") #=
v2.6.1-rc3
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2=E2=80=A6v3: https://lore.kernel.org/all/20250605060738.SzA3UESe@linutron=
ix.de/
  - Check for assigned per-CPU section instead of adding the SHF_ALLOC
    flag back.

v1=E2=80=A6v2: https://lore.kernel.org/all/20250604152707.CieD9tN0@linutron=
ix.de/
  - Add the flag back only on SMP if the per-CPU section was found.

 kernel/module/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 413ac6ea37021..cb281e82226cd 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1573,8 +1573,14 @@ static int apply_relocations(struct module *mod, con=
st struct load_info *info)
 		if (infosec >=3D info->hdr->e_shnum)
 			continue;
=20
-		/* Don't bother with non-allocated sections */
-		if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC))
+		/*
+		 * Don't bother with non-allocated sections.
+		 * An exception is the percpu section, which has separate allocations
+		 * for individual CPUs. We relocate the percpu section in the initial
+		 * ELF template and subsequently copy it to the per-CPU destinations.
+		 */
+		if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
+		    (!infosec || infosec !=3D info->index.pcpu))
 			continue;
=20
 		if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
--=20
2.49.0
