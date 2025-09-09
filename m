Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87123E34C
	for <linux-modules@vger.kernel.org>; Tue,  9 Sep 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436413; cv=none; b=eLSlRBEcB52As6kw51osPjTAAf69si5lpKvOxkNwRadO0hjsWllbL2lG/XSmRqbNLxKakmGp8HfNmkTOvMMzoU1Iq+YHL899vVBBeP383uBfgoh2OBJ8b+OoYNXM7eonmYeL84GfKpoofYg/MEKZsG1RbwdmCM6RXVGmqAVTwzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436413; c=relaxed/simple;
	bh=xOS9U4orWtLOAiOSXJArCP/d29jMdQiYMgl/bpHnYJY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=I1td37ZSXBJT0OXPo5KbO4z9VS5JyrSEZHYehGUfJZOYkm2tjGHnUVcvqCEOe/p5l9dZZcBEa5L1jlDsg0oyZapXhnBEk0Y6YyNShCJdGa+wXCwqSEWlGLPx6jUa+Vxv25ofeAkebgz6c2+2onfG2lrT/8lJhwOnCg94fTPJ7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhI8ujF9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhI8ujF9"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0446e57a18so66967066b.1
        for <linux-modules@vger.kernel.org>; Tue, 09 Sep 2025 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757436410; x=1758041210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An/UGM3uulfdmqhXwqkD0P+EkKuQ13f2Cvm0p4+pPss=;
        b=QhI8ujF9sU9xMR2WlMirr9trcZrFVhVaj0z+7w5X8TxV0cxlnMbN7v63BGYOmeH/6D
         ecB0f7oFlbmj7dsPcMVN1ZEw3b8i8SmRWGmZrrp04ZTQiSSOIokyOI8+M5KG+5LdzEvs
         wGyXgRRSiuFZ2PtYUSlYf4+xtNMkxhXSB65X4cycx4tTFA6WIYFlUAaJQvi3r8qWAQeZ
         S41vaJEfm3m+HtaP6wOxX+fkZA1NshLPKTBBTCHi4lGsIuT/06p5HNr3DCs2NK5olUh5
         RnxQsGP1+MJyyK1006UAul/KR7dXv947rXh9vsYq5xCCX2UA0AsAFwu5NeHWSTCGvkJS
         EECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436410; x=1758041210;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=An/UGM3uulfdmqhXwqkD0P+EkKuQ13f2Cvm0p4+pPss=;
        b=EYu0Lgx8jPmTFFsV2YStdWCuZ+6jo1pt8oi7JxtBIyNrMiNRj4aszSSp8youWQsd4M
         NApb1QW04SIsneAqb2dBWugnkF7k9Fh/EtDuSEXW6LmMMX/XM+SsZLl92cbr9g8go7R2
         M/pmoudOFwQ6Pq6pKdAOz+la42IJREyPJXIKcuz+uGwOtP7ggJp2/j8YLwvPhX/Vw4pO
         pONRUYGq1zrrAiTNRdvMlyccTMGAEpsuuZajhyYF4aHpfMWNx+OUATPvaLsmJ3Mh1xj5
         /WC2czaujgSY3JDObd5NfZP3/RG81+jmkbL6EuuyR6PeJ5Zp4kG24vdf6IhNQ3knJlEw
         IaNA==
X-Gm-Message-State: AOJu0YxixtQLKE5gu7hTeFQyHfRInP0PoCubFM7l6jBbIIFzOyO5QgKp
	dOuJzKrv1vINpfbr3wzktHFkfHuW8tOuSuAT7TlDqVLtNmGuzrEmjaI/JO5OzA==
X-Gm-Gg: ASbGncsdTMP6CiBtvF7F5aftWejm6+DNXfZRFnV4lF2mOtl3A/3tG64oBlaQMZj54dg
	M9pqwnWc70CWlMoqeCw436w9z6iUCZYofpIBH8pGAyz81uUYm3mrpLyaCL33KiEtOSlofvbSESB
	XK0OrlaRTQZox2ndoqu9O0uZQ8N4//6Pd9VmmLmv+9RIH23MmQdQPzxgrAkvolxypo9JWV+yQWs
	EugIAnFeutU+6Ny3AW6vmsb/+laK2scwh+xaqQffFKNxfpwkCxaR4jrowiZxWZRvChW2gxr2M80
	QXqH2O1fqXKrIcQ/MThnNFoz6vNj1ZBy0AISl43J/h7tN+NUagsuvatr8kxIEgUufALPp4CNJiD
	jzU31ecNe4H2yNs2KxARIW8hEpK48qlNcF6gX78Yg5s68QiNy6nEpmVyqH9qVDgfQB87L/DDGlc
	TxC59zeYGBuy+x
X-Google-Smtp-Source: AGHT+IHgU65qLc/NcklTM+mE0N1sMtmYf7VTT9q3rLDCvOakZCDNg+jICHyjwFoJVf+tQW1o8rWAFw==
X-Received: by 2002:a17:907:3d8c:b0:afe:c1c1:1bf4 with SMTP id a640c23a62f3a-b04b147d883mr499451366b.5.1757436409737;
        Tue, 09 Sep 2025 09:46:49 -0700 (PDT)
Received: from ?IPV6:2001:a61:2a86:3e01:58a2:d498:9ee2:37ce? ([2001:a61:2a86:3e01:58a2:d498:9ee2:37ce])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334b3c0sm16100366b.68.2025.09.09.09.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 09:46:49 -0700 (PDT)
Message-ID: <d1d1756a-2f6d-4b81-bd6d-50ddf7f39996@gmail.com>
Date: Tue, 9 Sep 2025 18:46:49 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Daniel v. Kirschten" <danielkirschten@gmail.com>
Subject: [PATCH v2] kernel/module: avoid panic when loading corrupt module
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

If the kernel attempts loading a corrupted module where the
.gnu.linkonce.this_module section is not marked as WRITE,
the corresponding this_module struct will be remapped read-only
in the module loading process. This causes a kernel panic later -
specifically the first time that struct is being written to after the remap.
(Currently, this happens in complete_formation at kernel/module/main.c:3265,
when the module state is set to COMING,
but this doesn't really matter and of course might also change in the future.)

This panic also causes problems down the line:
after this panic has occurred, all further attempts
to add or remove modules will freeze the process attempting to do so.
I did not investigate this further.

The kernel's module building toolchain will not produce such module files.
However, there's only a single bit difference on-disk
between a correct module file and one which triggers this panic.
Also, there are modules which aren't produced by the kernel's module toolchain.
(Yes, we don't necessarily need to fully support such modules,
but we shouldn't panic when loading them either.)

Note that from a security point of view, this bug is irrelevant:
the problematic remap of this_module as readonly
only happens after all security checks have already passed.
If an attacker is in the position to insert arbitrary modules into the kernel,
then it doesn't matter anymore that it's possible to cause a panic too.
And even in the hypothetical scenario where an attacker
can trigger this panic but can't insert custom modules,
the worst that could happen is a DoS
caused by future module insertion / removal attempts.

Signed-off-by: Daniel Kirschten <danielkirschten@gmail.com>
---

I hope that the wording is clear enough now about this not being a security bug.
What do you think?

In my first submisison of this patch (on 06/06/2024),
I was told to add this check to userspace kmod too.
If I find the time, I will do so, but I think that won't help as much
because there are of course other ways for userspace to load a module,
such as any alternative insmod implementation (for example busybox).

Regarding your "next-level university assignment":
I feel knowing whether the kernel toolchain can or cannot produce such modules
is a bit beside the point: _if_ such a module is encountered,
the kernel's going to panic, and it's not going to care where the module came from.
Also I'm a bit stumped by your wording "university assignment" here.
Still, I recognize that it would be goot to be certain
that the official tools don't produce broken modules.
So, I debugged the module build system a bit and found out the following:

add_header in scripts/mod/modpost.c:1834-1843 is responsible
for arranging for the .gnu.linkonce.this_module section to exist:
The C code this function emits defines the symbol __this_module
with two attributes: `visibility("default")` and `section(".gnu.linkonce.this_module")`.
In particular, __this_module is not marked const or anything similar,
and there definitely is no (supported) way
for the user to add custom modifiers to this symbol.
When gcc compiles that file, the resulting section is marked WRITE and ALLOC.
This seems to be default behaviour of gcc / ld,
but I couldn't find explicit documentation about this.
I even tried digging in gcc's source code to find hard proof,
but as expected gcc turns out to be quite convoluted, so eventually I gave up.

  kernel/module/main.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..c415c58b9462 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2092,6 +2092,12 @@ static int elf_validity_cache_index_mod(struct load_info *info)
  		return -ENOEXEC;
  	}
  
+	if (!(shdr->sh_flags & SHF_WRITE)) {
+		pr_err("module %s: .gnu.linkonce.this_module must be writable\n",
+		       info->name ?: "(missing .modinfo section or name field)");
+		return -ENOEXEC;
+	}
+
  	if (shdr->sh_size != sizeof(struct module)) {
  		pr_err("module %s: .gnu.linkonce.this_module section size must match the kernel's built struct module size at run time\n",
  		       info->name ?: "(missing .modinfo section or name field)");
-- 
2.39.5
