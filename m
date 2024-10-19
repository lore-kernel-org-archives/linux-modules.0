Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFBE537FF;
	Sat, 19 Oct 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347617; cv=none; b=YhxbNSG23SI1auOPEQLpjPmDsQuLj1eIwzrqhbx1AjXTooEl39yNCgFAXjXEaE965fkkXUL4NDzBCzUHPxzp/eLkLYrp8TD/1s5vrW/6s8/QoLa27h3ZH4YCwr7wzED9+ZzUz/PVeehWjo6TcOJc9espydYHYUHPxt0Y2VUC5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347617; c=relaxed/simple;
	bh=EubbHA9aWeqeVtquYU1NLEUa+R7xITfA/9u8hXxCp9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cn/SLGS7qxPvJfKfLVV6V3sv/7uZaGo/Sv8g5tfXPITc47KlIkz6WpT5Q08d4qY+BuH3QN78kwE4cXlzilnlUKwidJH7D+N+rNbXk+XDNtf8NdnFV2A5XJ/V5YVQF5VdPnMcBDMC5PsQwZ2KtcLnhUpMglOJnSmrJZ1QNZ/z3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stoeckmann.org; spf=pass smtp.mailfrom=stoeckmann.org; dkim=pass (2048-bit key) header.d=stoeckmann.org header.i=tobias@stoeckmann.org header.b=UEr8LM4h; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stoeckmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoeckmann.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stoeckmann.org header.i=tobias@stoeckmann.org header.b="UEr8LM4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stoeckmann.org;
	s=s1-ionos; t=1729347608; x=1729952408; i=tobias@stoeckmann.org;
	bh=YaO01H0aBFxXTIh6R9RLuOMde/+nhqIC3cIiUOtVZtY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UEr8LM4hJzDNQ0EKNFkxunkdMo/yID6FRlulJgS/xYK0LXgXISoI2pWjVkA0p0dn
	 +0lxYovsT1CvlJgct7EvftCVL7hAis6BwcKHaNERGMnvFcKh4Ujw/rsU4wD/mgP9w
	 vxh96Sa5aNYtTq3eEoY8gVD5xhD04qA4gQTZCX0G3j7UF48/nROlbttLUCHQJ4FB+
	 hqDuxHko4edudbWwi6pS1ES60MbQP/Nbjrk9B4xEB2K+sLnicLBHQz3OmEhdZkvgL
	 30heWsRdYbQ4C9UecJTTXa2GaJzBxIpqxJlvQiuPKQZvKbpjrOx6ZlRxC/bAXuKZx
	 a2X6yFIEblbfzAoFLA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([93.225.54.107]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mpkwn-1tiaKM2UxB-00jzEU; Sat, 19 Oct 2024 16:14:43 +0200
Date: Sat, 19 Oct 2024 16:14:40 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] module: .strtab must be null terminated
Message-ID: <5uwynkpfhtqbrq47nqvp2ixpjhstjl7o7uxqp3b6snj233tvzi@avfrbljjpdel>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:PC9FP5yhmpbpK6fq2dE79Avr/g93nX5OOYPuxBmEQZVfEsgWtgT
 UaN2/JEuYkrsKkURBEXtQvGrRqJYvmMbD+IJaHc1wsI/Ys80p/ixmpdNOrI9EMdn5R7qv9c
 oaz/xvmwdh3/F2dIcItmU8DJt6RGnHICnw5gnf8cGaN6NnDRcc7+aEbJyCk7ZX2qEw/C5P8
 28FjWnsAbdUGF0kbfxpmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TL6FhCzdM2A=;BK/7PJVqPBXIY6thjxytUMHdGGC
 LzuHYlqS7+QMmYO4De8vWeulVgYRpgEseKy/8csfAXHZfti/bvZece+O/Y1fjVFVh5B0rXbxo
 U9/JoN+c/AhoqesQIS6zkX4ZS7tFIDMSWmZUVvVS9X3jVEHzA01mqMOTbFIamwI368wRkBpgs
 ohbSeD+s8DEME1HzzGj9tM64Zw4oZ/Jstb45vf9LhilhF1ggV4C6Yz0VxOZOuetu/4HcvvfNc
 eNGeD7dvsAaBXc+DO2gM6TqzbV1hbelczI+TTFt5MPKYF5GXmLsoPmT+wAuo6V8kcbRW8SOUj
 /uArIhToH4HJr2V/9eOA3xhaJDx2h+Y63yvtCF+rQTqmEE1k5pH8vNniR32m/p/47aDGM/blO
 3H7dZivJyOBNCSk75poiGDB3yjyQ+lKHps9hLndhvEZKg+9SQemCpiCh8UU/68Eh+gTdvub62
 883JGD6WZgAfSoielgRWkJarjWn9ZhGM7DYqwd9Q/All3vbNao+XWkuVE7uouYFSsvKglEjsH
 yOpfWq/YDZCPrUxNRKQmnhVFn1hVbfM0gganpkej1Jciy6KPgUsj/b5HMwYxI8dBTZmlS10tR
 yhyiVvMIXeuaaTcy6XpNG8l6g7QzIa5h0R6zhrPqcCDTKiHJQJ6iWjPpXh5gCmB+H5TySaJWY
 Yb3HXLc53Vk5fMF1praM84OqvlhD83YPvxx6nracvbjoVW2P2mZNDqU2y2iMIT0tbl+Cgu2lw
 Xt57EWlkUGxo1rEjErfa6fqwZnrcVfCcQ==
Content-Transfer-Encoding: quoted-printable

The string table must be NUL-terminated, just like the section name table.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
=2D--
In order to create a proof of concept, which I can't get into a simple
script right now, it's easiest to move '.strtab' to the end of the module
file, write as many 'A' characters at the end as required according to the
section size, and try to insert the module.

In dmesg, you can see lines like:

```
poc: Unknown symbol AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\xc6\x=
e9<\xfe\xff\xff\x8b
\xff\xc1\xe9\x03\xf3H\xa5\xeb\xa1I\x8b~ \xe8 (err -2)
```
=2D--
 kernel/module/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9d..9c5b373a7 100644
=2D-- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1847,6 +1847,18 @@ static int elf_validity_cache_copy(struct load_info=
 *info, int flags)
 	info->index.str =3D shdr->sh_link;
 	info->strtab =3D (char *)info->hdr + info->sechdrs[info->index.str].sh_o=
ffset;

+	/*
+	 * The string table must be NUL-terminated, as required
+	 * by the spec. This makes strcmp and pr_* calls that access
+	 * strings in the section safe.
+	 */
+	strhdr =3D &info->sechdrs[info->index.str];
+	if (strhdr->sh_size > 0 && info->strtab[strhdr->sh_size - 1] !=3D '\0') =
{
+		pr_err("module %s: string table isn't null terminated\n",
+		       info->name ?: "(missing .modinfo section or name field)");
+		goto no_exec;
+	}
+
 	/*
 	 * The ".gnu.linkonce.this_module" ELF section is special. It is
 	 * what modpost uses to refer to __this_module and let's use rely
=2D-
2.47.0

