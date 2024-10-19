Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C0529D06;
	Sat, 19 Oct 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347667; cv=none; b=IM39SBSAGP0078HOcoSmAfk7v5BWXv4NM5jzfUPRkmQd62npRNChX0uz31p4Lbse/iuzbso7Bqkmal0BtVAyeQ4WVhic06y5J4aqFmNmmZFYi69+8R2zYLRPfMrCDin4LG7cbxtkbIzYTsTpupeGUw+yXqCv+/Z4eDoh3l+TDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347667; c=relaxed/simple;
	bh=c7RiOr1Ac/fzc8VMDMux8kD1mZMdxJEJAcE0RWw3ieE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ocbv0F3wxYnyrWlea4XkuqtYBDrso487iiFAR8M0ZbHbSP/u0u52dXziFiEaOSuj5/Pikl+hbNEykX0ctvJvVkydWMvM8qjYDsRck558i5wfVWlwPAAjoFxPotFjTFeZ6dDdbJuyMa57XaAIs6tTiUo7tdb9VxcMb9f5dV469kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stoeckmann.org; spf=pass smtp.mailfrom=stoeckmann.org; dkim=pass (2048-bit key) header.d=stoeckmann.org header.i=tobias@stoeckmann.org header.b=dhFnehI+; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stoeckmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoeckmann.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stoeckmann.org header.i=tobias@stoeckmann.org header.b="dhFnehI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stoeckmann.org;
	s=s1-ionos; t=1729347659; x=1729952459; i=tobias@stoeckmann.org;
	bh=3nKCnyI8qt6wdcOrLc2pSwcWxAAi245mb4c+KnX/UsI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dhFnehI++eTfUBOOdo9amJ/yJpFFJg+cXYKET3Of3Ad4zlQO5DzjZ4Fu6RtrKudj
	 vH1uqAuUNC0Q2nsmfrhAW/aHfvF0bL6u/1mBPddFe/WFpOXpzfXCRkgyZZJrR5dry
	 tzYfp7ikrjqOFcjga6NBEHf/sDFPxP01d71EnMne9xIR/QJzSEv9uFG6S9lvPWbSi
	 RgtLFFg/W84CXp/SNLMllWN88e6obCEcHkwtrNHcbfyN7QMJJOARRKOm6VvWnoj2b
	 Qag83x+R/X0jB1aqZZ1eBVfuItgCKTEEC9liA684AfwieSRocDaTalJgq82LxifF8
	 EHM845CwXmcD7BBpFg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.225.54.107]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0Fl9-1tok9h3S6B-00tAbZ; Sat, 19 Oct 2024 16:15:34 +0200
Date: Sat, 19 Oct 2024 16:15:32 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] module: check symbol name offsets
Message-ID: <2hhrajjoxixnkhtlhhqzjxki4iuhr362345wgrmg6uzbfhlupo@hgbjsb5wizir>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:/tAdUMrLljt5tYcwL6EGwqCKXUJdCEO67Ni5LiSUiK+AX2N+jps
 1M55LaDgbJhMVZlpz/gE/ccm5/NhhjFh6h2agfeF5TytVY8jmnV8aI9v1sFcNyOdzyYfreB
 j1Ek7mz8DNueHGh4v5OrQSew0VlWjlWdGOq+Es8w2Qn7Ehc9UmClgnzjNJTzNUyWxx8fQJM
 3Ls+fQN+YrDCLBF/paFPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C0dOTkl2OKY=;CRRWzZnronMJlRcvVLU/G0IH63X
 m/eYZNV62zoUZS2v+X9os074J0jKj7jJm72LIpTcTsWvGhF1WovKccJSoqlCkOYD+H2fZd1Id
 4drYouWGForjhGukf+pJ51Q9MkSEkT5VMi5Sq3T6TDs0ciqR/6dLimVxfCDxRQShXzhUpbfQt
 KWJNUpMWOv2nGyl9ZfDR0EPOct99QlMRIvNQIh2UA+FVBqy7qv02rOxAjOsJ08x+c5K0l12d+
 E4sfFcycdzQWYZuZMu1Iyh+On6HZ2GI6WsqlgaJ/3Mvr4a91O8eRJBOC7NPuQ9hK2oSIIplsd
 k5VACNBlQTnEkyF/Z0We3rd5bziPNgWENG4HQxbyWNn050aBes7qOWR6Xkq2QaEN4JfLrRbZe
 /tluUzkwoe4fAE+ZyPx9X0rANxPB5pwAwcNpeKmONWAw4xiq+FufFRDPsklutGnOiI90oGoOv
 no0Hx0X4RkdCV9DXXC5fEq4bb5ig9Ln8XYDFIXsjNflcmj4bJ9HrP36NQ8ANFQkBlocW5K4N4
 /0Hzgeqe3rKcRUDrl7Rf8EeIYyev0FNDFoA2r+OLc6e+il6rY8A5r0MdemxkgreorcKEX5e7G
 Rvto4yVK8uWFPbJ9Yp2srw7ue6h0l+0svBAGBcXKyV126qClfb86ANbSmTTGDcnMbafF0IXca
 sQ00drXYzjrrcXE6bDsH7Zf1OuPhfERzgIvoobOIihU3tTE70ClwPZuBIqM3ILMAw8Aw0DtWy
 8qhHF/RHKm234CfDsROS+hjtQ27XgMH6w==
Content-Transfer-Encoding: quoted-printable

It must be verified that the symbol name offsets point into the
string table, not outside of it.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
=2D--
Proof of Concept:

1. Create "poc.sh"

```
cat > poc.sh << EOF
#!/bin/sh
# Sets an illegal symbol name offset in supplied uncompressed module
# usage: ./poc file.ko

MODULE=3D"$1"
BASE=3D$(readelf -S $MODULE | grep '\.symtab' | awk '{ print $5 }')
if [ $(getconf LONG_BIT) =3D '64' ]
then
	OFF=3D24
else
	OFF=3D16
fi
ADDR=3D$(python -c "print(int(0x$BASE) + $OFF)")
echo -n 'AAAA' | dd bs=3D1 count=3D4 of=3D$MODULE seek=3D$ADDR conv=3Dnotr=
unc
echo $ADDR
EOF
```

2. Choose a module which works for your system (adjust if compressed)

```
cp $(find /lib/modules/$(uname -r) |grep ko$ | head -n 1) poc.ko
```

3. Modify module

```
sh poc.sh poc.ko
```

4. Try to insert

```
insmod poc.ko
```

In dmesg, you can see lines like:

```
BUG: unable to handle page fault for address: ffff9802022d6f81
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 100000067 P4D 100000067 PUD 0
=2D--
 kernel/module/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 9c5b373a7..c926960ae 100644
=2D-- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1688,6 +1688,7 @@ static int elf_validity_cache_copy(struct load_info =
*info, int flags)
 {
 	unsigned int i;
 	Elf_Shdr *shdr, *strhdr;
+	Elf_Sym *sym;
 	int err;
 	unsigned int num_mod_secs =3D 0, mod_idx;
 	unsigned int num_info_secs =3D 0, info_idx;
@@ -1859,6 +1860,17 @@ static int elf_validity_cache_copy(struct load_info=
 *info, int flags)
 		goto no_exec;
 	}

+	/* Symbol names must point into string table. */
+	shdr =3D &info->sechdrs[info->index.sym];
+	sym =3D (void *)info->hdr + shdr->sh_offset;
+	for (i =3D 1; i < shdr->sh_size / sizeof(Elf_Sym); i++) {
+		if (sym[i].st_name >=3D strhdr->sh_size) {
+			pr_err("module %s: illegal symbol name offset encountered\n",
+			       info->name ?: "(missing .modinfo section or name field)");
+			goto no_exec;
+		}
+	}
+
 	/*
 	 * The ".gnu.linkonce.this_module" ELF section is special. It is
 	 * what modpost uses to refer to __this_module and let's use rely
=2D-
2.47.0

