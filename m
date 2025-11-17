Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C4340A67
	for <linux-modules@vger.kernel.org>; Mon, 17 Nov 2025 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411894; cv=none; b=hPAZpWUqKAQ26WYMcrdb2H7+QFowRDvD8WSkW2/SE/ZdveHVPSS0TTyl/qgqxOq+blHzS+DFVe17iNeSZiOlOWfYqBW6BE0qTwp5N879zcHpo7RkZ5LcKVhlzHnAi32987/YhbLsv6ZxCTA6WyfMKtH31Pat3TyEGYSJlLyJ76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411894; c=relaxed/simple;
	bh=lmm7xZu9vIWRC/0I8HIYl9OtdLf+eJUTiRP2chK2g1o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FpjTT8iEVATYUSPycRfEamE094ekCWDhWhC3hHR+VyYzdE88epf1m2DL1MMJPl6z+OKLJsgJ6wDEFD1xhMYo9sGzJMPbBfQ5UuEh2WLyS3J8S58i6AefBlPi3T2JUw+9ltymU+A5JWvVohvRwrRO6ywxatZXK1iHYKj7CxUS1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cNcOG/pk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNcOG/pk"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so10283907a12.1
        for <linux-modules@vger.kernel.org>; Mon, 17 Nov 2025 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763411892; x=1764016692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAVkLcKcCYKXTFq0TOIQZY7P6FpG3/4XPeGtMM9owIQ=;
        b=cNcOG/pkFJwc91VpS/pcOPmaylzL9E3QvMln43PezYHVnf1TF+pzf5Tl/90zhpmbMk
         7bhL5srR2Es+w05N8udjAj79I3zEXny0U3n0qQYA8672ymmGtOqcYmS/uz2wsQ/B8q36
         GEpgdmdc95rTdHpg7+wWhHlfEzsABW5LUjJPHOQdGWi2nk2pw1FrNbSfST1Gao/ehBdM
         XAdFnRtoJa7sbtJ3m6t5C5UY7R0LGJ3HG38Y3VhU5WyOz59F2qHeOaSqQLOtTyQ7U+mB
         7SieHYlGaH3k4yKXiObLl90qVQQoWbYLNp7uoeM5Dis6pls8sR8b+MZJLtw7F5droV3X
         6e0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411892; x=1764016692;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAVkLcKcCYKXTFq0TOIQZY7P6FpG3/4XPeGtMM9owIQ=;
        b=OLzBTEHfsufzHDfVAWBuOrlgDvwViuh1WcogECiF2HQwoWyRpMPP8G662wIpjk1BAP
         7NzqgqJRC81ZI8kd1m3yXi63R5NFq55o8NEo8sJkiX4Hl/iZy7+s2aIFsTHeOWvPoZv8
         IA/MHpTvqBPEFbgD//3hGUIrLlkacYBePbTEQio+1G9UudqSIGFN1G8r4W7sx3p776zd
         fCrpOREPENNhU70o2zL3WJ17bAqQiJ0dpSwlIclizCnc2C2V44hCRtWdOnOi5Xqu1BDh
         h/ddoiLDHzXX+5A2IWc7CUyx+rcdS8DrWS/atI0SCPxV8Hj56m5iFr9k6k5RzChmT/cG
         hnHQ==
X-Gm-Message-State: AOJu0Yz/YiG/KjfjZLb0+8QhvK+PipFJZ62mVg1j+KesRrjhGE1Dgunr
	8kluGwZDeNKW1wwTS+g3gk/RGM6iTl4Ky+pJte3+/Q7Y6GHFKUd+NOZEjgwSKH2nX6b/OEzAX3T
	eYP7Q1DK8ms+Lif5kvAgWqi5bQiXFZpypTV3g7mjT8JDcELDfFR5cBWS/R9mQxxuHCrQuUARHtB
	ORCvD/knTKWJVW37i+2sJcw7Z0x3lF0vvlfdrY1KWv7MaFmRR/NUQc1yWFN1gWvXnU2oPV9m4uE
	F/hKg==
X-Google-Smtp-Source: AGHT+IGAdp4z6HWG0Pq4FjrMPMePj7oMwnFog0nNl4LxcvRd6e0MMvcbsVGGvEMzO2xGW0wrKx1M6EyxpVGXTAaFO8I=
X-Received: from dlbay38.prod.google.com ([2002:a05:7022:6626:b0:119:49ca:6ba8])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:5f18:b0:119:e56c:18b8 with SMTP id a92af1059eb24-11b41705b16mr4591063c88.32.1763411891886;
 Mon, 17 Nov 2025 12:38:11 -0800 (PST)
Date: Mon, 17 Nov 2025 20:38:07 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544; i=samitolvanen@google.com;
 h=from:subject; bh=IiTMCjudn09ARAqSHDWq99cozFbotruioqqqVlgFGlE=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJnS7esmfXt+9Iibg5+rxNWfx6Zmt7r6J6Z4ls4SDnodt
 tT//MuDHaUsDGJcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAiJy0ZGb5z//vx9vBvv9oq
 dkG/7eZNFx8E9LRdlzfVcL0pkcYhsY/hv9sf//Pq4qZzFs69lpNoLM6+mdk7p/vhp17dJzZPUr6 LMwEA
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117203806.970840-2-samitolvanen@google.com>
Subject: [PATCH] gendwarfksyms: Fix build on 32-bit hosts
From: Sami Tolvanen <samitolvanen@google.com>
To: linux-modules@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Michal=20Such=C3=A1nek?=" <msuchanek@suse.de>, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We have interchangeably used unsigned long for some of the types
defined in elfutils, assuming they're always 64-bit. This obviously
fails when building gendwarfksyms on 32-bit hosts. Fix the types.

Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
Closes: https://lore.kernel.org/linux-modules/aRcxzPxtJblVSh1y@kitsune.suse=
.cz/
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/gendwarfksyms/dwarf.c   | 4 +++-
 scripts/gendwarfksyms/symbols.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 3538a7d9cb07..e76d732f5f60 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -750,6 +750,7 @@ static void process_enumerator_type(struct state *state=
, struct die *cache,
 				    Dwarf_Die *die)
 {
 	bool overridden =3D false;
+	unsigned long override;
 	Dwarf_Word value;
=20
 	if (stable) {
@@ -761,7 +762,8 @@ static void process_enumerator_type(struct state *state=
, struct die *cache,
 			return;
=20
 		overridden =3D kabi_get_enumerator_value(
-			state->expand.current_fqn, cache->fqn, &value);
+			state->expand.current_fqn, cache->fqn, &override);
+		value =3D override;
 	}
=20
 	process_list_comma(state, cache);
diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbol=
s.c
index ecddcb5ffcdf..42cd27c9cec4 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Google LLC
  */
=20
+#include <inttypes.h>
 #include "gendwarfksyms.h"
=20
 #define SYMBOL_HASH_BITS 12
@@ -242,7 +243,7 @@ static void elf_for_each_global(int fd, elf_symbol_call=
back_t func, void *arg)
 				error("elf_getdata failed: %s", elf_errmsg(-1));
=20
 			if (shdr->sh_entsize !=3D sym_size)
-				error("expected sh_entsize (%lu) to be %zu",
+				error("expected sh_entsize (%" PRIu64 ") to be %zu",
 				      shdr->sh_entsize, sym_size);
=20
 			nsyms =3D shdr->sh_size / shdr->sh_entsize;
@@ -292,7 +293,7 @@ static void set_symbol_addr(struct symbol *sym, void *a=
rg)
 		hash_add(symbol_addrs, &sym->addr_hash,
 			 symbol_addr_hash(&sym->addr));
=20
-		debug("%s -> { %u, %lx }", sym->name, sym->addr.section,
+		debug("%s -> { %u, %" PRIx64 " }", sym->name, sym->addr.section,
 		      sym->addr.address);
 	} else if (sym->addr.section !=3D addr->section ||
 		   sym->addr.address !=3D addr->address) {

base-commit: 6a23ae0a96a600d1d12557add110e0bb6e32730c
--=20
2.52.0.rc1.455.g30608eb744-goog

