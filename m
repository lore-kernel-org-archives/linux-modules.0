Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AD14B95A;
	Wed,  8 Jan 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327118; cv=none; b=fJl7/1qPAPhzoORScBv1pPFj7AnaZ47EkEWoic5UTzBrhma3C/res7c6avi8jhldj0ke4O/ebgo8vJKiVA+ZUCSstZvDGEAVM5s6ffRhzd/9+xAy8rrMV+0u0WHNe7qubP8Q7S40gcA+QgZP73snTgHNcA8WPuZ8VFkXxCzlZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327118; c=relaxed/simple;
	bh=zJzXwl6QYBFCHDOHlQ0pCX7P/0Z8hVJ6wcBRmnq1Mr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAtU8jLn4qlECGw/CIZM3G9Fo6zvrwbo8IX1q6auE37Sv6QVlrhMZM4ckeKB6lVT6XHCIZF61nhvv3NA8BPk8o0aLUZMqM/jeeEwv/yaU8vR/n8OeS/LgA3XPqXIydYHlWwuDrSaoAPYzAlZ06YqT823Brik/Y8Ab4AsOaTgHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMGu5mNQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eQ+S/9fz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMGu5mNQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQ+S/9fz"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqFCtsDnDVNdkbpS3y+1msrlanYbghspKlyRIpJlAgU=;
	b=dMGu5mNQ5Cy1C6m/T4Ld6y7GnPIo9vXCghR6ekMae/1QrCEEHq25IbnRnluJGT0umag4Pf
	rhYW7zU7Kbzncf5TEw0o77Qub34O/dCmoqlLG+V6U6Q0C2xArd9Gpmv5Taa2fZACDMUXQI
	raYO8jUDtCHnCzSbQa/+XWPZ4pGI9x5SZyNjCul5PhVjLDdlholVOY0hvfORVXgfrXlGOa
	KK2KTJEdfN/sIkNitSPndgnkH3uG26tgxBdDdDXbR3jbJobJNk2Bl+2KCpQhI8ZXmMBQLf
	rqbAZA25Mwb6if0aWn8fUt/AQxVBSVS/DSFBoMnEkwYE/4AfdlLYGtX+YVEPRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqFCtsDnDVNdkbpS3y+1msrlanYbghspKlyRIpJlAgU=;
	b=eQ+S/9fzFkx7/8onRJrmK/0J5ltmUAMyMKtwO9OofqDZAk5UNG+/h9kK38MIVE3AIPg0n0
	nvTREfKfa/Sqw0AA==
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 03/28] module: Use proper RCU assignment in add_kallsyms().
Date: Wed,  8 Jan 2025 10:04:32 +0100
Message-ID: <20250108090457.512198-4-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

add_kallsyms() assigns the RCU pointer module::kallsyms and setups the
structures behind it which point to init-data. The module was not
published yet, nothing can see the kallsyms pointer and the data behind
it. Also module's init function was not yet invoked.
There is no need to use rcu_dereference() here, it is just to keep
checkers quiet. The whole RCU read section is also not needed.

Use a local kallsyms pointer and setup the data structures. Assign that
pointer to the data structure at the end via rcu_assign_pointer().

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/kallsyms.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index bf65e0c3c86fc..45846ae4042d1 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -177,19 +177,15 @@ void add_kallsyms(struct module *mod, const struct lo=
ad_info *info)
 	unsigned long strtab_size;
 	void *data_base =3D mod->mem[MOD_DATA].base;
 	void *init_data_base =3D mod->mem[MOD_INIT_DATA].base;
+	struct mod_kallsyms *kallsyms;
=20
-	/* Set up to point into init section. */
-	mod->kallsyms =3D (void __rcu *)init_data_base +
-		info->mod_kallsyms_init_off;
+	kallsyms =3D init_data_base + info->mod_kallsyms_init_off;
=20
-	rcu_read_lock();
-	/* The following is safe since this pointer cannot change */
-	rcu_dereference(mod->kallsyms)->symtab =3D (void *)symsec->sh_addr;
-	rcu_dereference(mod->kallsyms)->num_symtab =3D symsec->sh_size / sizeof(E=
lf_Sym);
+	kallsyms->symtab =3D (void *)symsec->sh_addr;
+	kallsyms->num_symtab =3D symsec->sh_size / sizeof(Elf_Sym);
 	/* Make sure we get permanent strtab: don't use info->strtab. */
-	rcu_dereference(mod->kallsyms)->strtab =3D
-		(void *)info->sechdrs[info->index.str].sh_addr;
-	rcu_dereference(mod->kallsyms)->typetab =3D init_data_base + info->init_t=
ypeoffs;
+	kallsyms->strtab =3D (void *)info->sechdrs[info->index.str].sh_addr;
+	kallsyms->typetab =3D init_data_base + info->init_typeoffs;
=20
 	/*
 	 * Now populate the cut down core kallsyms for after init
@@ -199,20 +195,19 @@ void add_kallsyms(struct module *mod, const struct lo=
ad_info *info)
 	mod->core_kallsyms.strtab =3D s =3D data_base + info->stroffs;
 	mod->core_kallsyms.typetab =3D data_base + info->core_typeoffs;
 	strtab_size =3D info->core_typeoffs - info->stroffs;
-	src =3D rcu_dereference(mod->kallsyms)->symtab;
-	for (ndst =3D i =3D 0; i < rcu_dereference(mod->kallsyms)->num_symtab; i+=
+) {
-		rcu_dereference(mod->kallsyms)->typetab[i] =3D elf_type(src + i, info);
+	src =3D kallsyms->symtab;
+	for (ndst =3D i =3D 0; i < kallsyms->num_symtab; i++) {
+		kallsyms->typetab[i] =3D elf_type(src + i, info);
 		if (i =3D=3D 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
 			ssize_t ret;
=20
 			mod->core_kallsyms.typetab[ndst] =3D
-			    rcu_dereference(mod->kallsyms)->typetab[i];
+				kallsyms->typetab[i];
 			dst[ndst] =3D src[i];
 			dst[ndst++].st_name =3D s - mod->core_kallsyms.strtab;
-			ret =3D strscpy(s,
-				      &rcu_dereference(mod->kallsyms)->strtab[src[i].st_name],
+			ret =3D strscpy(s, &kallsyms->strtab[src[i].st_name],
 				      strtab_size);
 			if (ret < 0)
 				break;
@@ -220,7 +215,9 @@ void add_kallsyms(struct module *mod, const struct load=
_info *info)
 			strtab_size -=3D ret + 1;
 		}
 	}
-	rcu_read_unlock();
+
+	/* Set up to point into init section. */
+	rcu_assign_pointer(mod->kallsyms, kallsyms);
 	mod->core_kallsyms.num_symtab =3D ndst;
 }
=20
--=20
2.47.1

