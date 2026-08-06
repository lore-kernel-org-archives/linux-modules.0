Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A4448BB7;
	Thu,  6 Aug 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026558; cv=none; b=kSXN0/6ohR4nIQzBUPD7Gi+UpGtTq4ZfXVu9dWz6kf4vkRzNQneQV9ptfjv/WV67M7m3KUF4ybEhxfPslLWvwikMWKuInYcUZBWB50gIh+gT00i+uXtlNr5fvLi/+W2HVCbuqdI4v+jz9z7j85/orPLT8EZacFvBzbYIEH78ejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026558; c=relaxed/simple;
	bh=B0SivBUOk/20wJkEEQ4Cb4wvxNy+sxCmLf420Yka4Vw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nH+HsZJSTtDEiwdNv1ISmtCwH8MSoBg/l7MV3DUwvx/XHzWcYQr9q2mJl2LN/rvOJltOcR+MoNFzBOV/Ktl6cTHYmPYgDLSYpiAzTRLvkehpe3ZIk6Q+OetXkyFhyBfNE8PYvrhXhxtSPe1fwQZU3sTZSZhUZvHO++zudPWpE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=eBQa4fXa; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="eBQa4fXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786026550;
	bh=Imv49H40T0imiJVvA5Q+dNmyVovxOuHkUmfa3LQqk7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBQa4fXaZ/6cO6CxqAyQxP+q4iDPetPuo+2+oyOftUzBDq439TQP0IC7uKEj/wvkI
	 VNF1aQQU8KaZZriO+eMdYv5GduKEC5nUJX06HDpRrST+aS6KqYZYygvfojkDHDISEb
	 XG51Zs2xFT/NoEzCbST2BoWu0K3/X81ZKt6v5MLg=
Received: from LAPTOP-JJ91J38E.localdomain ([222.125.130.218])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 748356F9; Thu, 06 Aug 2026 22:29:08 +0800
X-QQ-mid: xmsmtpt1786026548tsmliq47h
Message-ID: <tencent_EB65B78E967A5FF9DD2A591A86A6BD5B1107@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJxH88aSLvsUB8t2+Q6jLrWVYFcYkO53eDw7PcGWqVicODoTZS6q
	 S8dR2Y0FhxrwlZJlljKYEbO/UOj6rRARVQLTCWxWDr13LHBES5XRD3wb53CP6xDjAyULryaJnoat
	 bY+KmrquEITnPedjoolbb4OKO8J/5gk/WqNOeAvgSn8A3dZsY0V2Os1e/eqoLgSlHSglgjLRaHR9
	 dcSrMN2ciT5OAR3KP/mF3PWH3MzImuuiy7fJOlZ1/0NQdPyzrsJZOv+m5lKMtCoK3e3XKNp3KXJN
	 2zUw1JyN/behvw/eIPDH1btZG8m7/khPHd1XNQue93naPOmOmbDJKHpdHfOqCUYWNk0qEXgWkymf
	 nLdDxpZbzIOXu1XXZBMgUmlrOPKhK215VYj2M1d4L/wo1YxDIfeeW9H+c3EDMXThn2TP23zreYHr
	 aIw3+ZchyAuialvzobuKNR3C/QHDqElz8DUWuej31J9IpSyjQlClb1NY/dypOvgt60zP9zaOaqpv
	 wMTk5XLWtI7Yno08zkqLHQfJxKg39lvr6UN3kTyJ9LgCHc1wP2A4xcX8vq/pcvVbErc7FHzmwdwh
	 sojJm0mzmJC2FGJn8Itu9CPwWJzK0p4JOoxy4iRNJFHXKS3ulgto7V1trrwcDt970RwFD0AbWTOO
	 xc1rlJsN8b0VJNK27vLEGv0mTP729S4+/Wd99cDRr8XImsRbyoqR6QC61M+ayteGoux/3VFMejIk
	 EEgKSK9p9/v1um/T+qLR60UCiqDQuVox1Tu4oH4Ax3GRxKTjitQQW/gaeE7ulj0t2OMBGWCSkPaC
	 iPhd0+AFZ10Zo/UoNZHHR17sxodZzqSLGzm7af+BWBT4FGAsbDV1JVWJV5ONcJ0VZHGQ0Hq/myWB
	 u41bhcMHyzv1zxqiWTWFF+e5KyytwWeBOtWJmvS4yrUQwQxVoBJBbXbO2lRV9zCf2/g+BDlPkkEQ
	 AqBBIlVkwYgCgYRBNjUbK9i1wsVinIonu+GCLjzFzHePbPRyv+ae7USNstD+N9IhMtUk2BvSmogx
	 2OhG6HOyLaQveYaoGc6jLImcdLBXY5O7VNA66J6ntc+CRCweY3X+k61drtt5Y=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Xiao Junzhe <egg12138@foxmail.com>
To: xieyuanbin1@huawei.com
Cc: linux@armlinux.org.uk,
	jpoimboe@kernel.org,
	pmladek@suse.com,
	linux-arm-kernel@lists.infradead.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: module.lds: fix unwind metadata for merged .text sections
Date: Thu,  6 Aug 2026 22:29:03 +0800
X-OQ-MSGID: <20260806142903.2601608-1-egg12138@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806130212.48727-1-xieyuanbin1@huawei.com>
References: <20260806130212.48727-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for the suggestion.=0D
=0D
I had already noticed before that the current GNU binutils does not generat=
e=0D
.ARM.exidx.text or .ARM.extab.text for the plain .text section.=0D
=0D
GNU as special-cases an exact .text section name in=0D
start_unwind_section():=0D
=0D
    text_name =3D segment_name(text_seg);=0D
=0D
    if (streq(text_name, ".text"))=0D
        text_name =3D "";=0D
=0D
And after your reply, I checked LLVM founding it does the same in ARMELFStr=
eamer::SwitchToEHSection():=0D
=0D
    StringRef FnSecName(FnSection.getName());=0D
    SmallString<128> EHSecName(Prefix);=0D
=0D
    if (FnSecName !=3D ".text")=0D
        EHSecName +=3D FnSecName;=0D
=0D
So, with both current implementations, the mapping is:=0D
=0D
    .text       -> .ARM.exidx / .ARM.extab=0D
    .text.foo   -> .ARM.exidx.text.foo / .ARM.extab.text.foo=0D
=0D
It's correct that .ARM.exidx.text and .ARM.extab.text are therefore not=0D
generated by the current GNU or LLVM implementations currently.=0D
=0D
My reason for including the exact matches is slightly different.=0D
AAELF32 defines these section namespaces as .ARM.exidx* and=0D
.ARM.extab*; it does not require all ABI-conforming object producers to=0D
use the same naming convention as GNU as and LLVM.=0D
=0D
For example, another producer or future version of GNU/LLVM impl for `as` =
=0D
could validly use:=0D
=0D
    .text -> .ARM.exidx.text=0D
=0D
And our topic is about text section merging in ARM32 unwind section layout.=
=0D
=0D
Without the exact match, .ARM.exidx.text would be left as an orphan=0D
output section, while .ARM.exidx.text.* inputs would be folded into=0D
.ARM.exidx. Since the corresponding .text and .text.* inputs are all=0D
folded into the final .text output section, this would make the unwind=0D
section semantics a little bit asymmetric.=0D
=0D
That is my point why prefer to keep `.ARM.exidx.text` matching.=0D
Hear what the other reviewers' comments.=0D

