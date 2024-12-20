Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8302221C9EF;
	Fri, 20 Dec 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716861; cv=none; b=NRFIVdy6xltuyMzMv1v8Wx/D9xQ5oPv39Iu/8W7/b63d9RbkKan+8wmmARwyFveq1L4rC+ETB/OfkwKK7V4wm2qte7u0hiTqy/eQaP7V+6elvZQRdN/Ir0q07Ze8Z0W1am3Byzb6cGpHp5Le5PDQ7nGXxyJZkDtY0ivEgmMyIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716861; c=relaxed/simple;
	bh=ApxMQvvcCvnB5ydSNW0iQzeRyKqqIkkgQTrsnUfXqX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHN7AGobhb3JTbXGoHpWUAcpZySshFGn/fNMQv1M3bLpoCeXBkKdF3fhOYVjqXWNliyto+SAj0p+UEB8hsNCqOvnRfs/WjjcYNX1ucE+DbXfvkCOO/qo+aeCgsPrLhm6vPzJQWmkjy8o86J9lgkud8c+Pr07+CCUwjkoWp3/hYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UzPefDkJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XFV5oera; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UzPefDkJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XFV5oera"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQ6ZqxuwJeNb/vKpE3WEBj3zTXNytGr0GQv7pX1w1to=;
	b=UzPefDkJBXEBPRcOg51PLcgiYOmoVQvAfNE6budNXvJeQ0Y/rvWgvX945kODJtJgnHSQco
	3n/X4L8NYrsD2FYRjRLvWsbE3y27iLoGprzkowXGaV90DNfNMSlZQU4JViVfmL2gLxE/jW
	lDiUEHvc035IZ99+pRGbvsIFbc2YxFfp858r0qjWQMzcJkWs81V73i2dlRm+4+hwJmmUV/
	2rMJYpFFA8I+1A19m2xlsF9G8EOfQtOTiKBcs5xt9V5mVvYuvQ6JpPQKKErYdkqiqsQ/iD
	ZVDFLin9DVDQFKa+Tf6LhW2aj11gh66+LkKaEyDwMYQKhAHrSehXM1DTFE790g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQ6ZqxuwJeNb/vKpE3WEBj3zTXNytGr0GQv7pX1w1to=;
	b=XFV5oeraBYcJoGPH+xe621s4U2cGAEAwxxLYBpAgHvuuxbj+tO1K7rQJMNhSzcQmFdy5Hf
	3AP89P23zOluCGCA==
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
Subject: [PATCH v2 03/28] module: Use proper RCU assignment in add_kallsyms().
Date: Fri, 20 Dec 2024 18:41:17 +0100
Message-ID: <20241220174731.514432-4-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
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
2.45.2

