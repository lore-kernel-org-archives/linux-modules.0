Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608042;
	b=DhdumvftvE3LczbePB/KSOmwP7QfyWw0Il+3BBBzQ790dxoDpSazWMiNTy9bHKy3EIx5
	 bv5/b7blgsEKG4eYN0qVWIEDqw0OTwdKJ/EUmcqCmRDP84LJxzEFKQiK+cYPo1TLI7Abg
	 8MLIuxxjj89yx3C0LZA4vbOFnjeXQqDHebQ/TwbmWEUFRVphadSOsQ00E4ooW6VRDZqYR
	 UXizlNASXi8fGSffHNPrqi0P30uQvSFOcnP4LEt4OHNaOypK2qyJC6C0+uG8+HjL1lZt0
	 +iKyklusHyOMlzxLBV1I8W7OTCutSbuLXpoHGKVWjwqJqjuq4pDyRXzKuXeViRL3bPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EfW5r72ztIVpTPsFjdHYnm3oK6ZY2qO8ZM5ubM8gZAk=;
	b=GCktjaV08UkXgH1Zgr+Imixyh3uLLRWxqLjq1v7eEd5xegDQZZWfyzD1QJ3ssoWCycjR
	 YhxE5eNFCc8hVnc+hJM47OYkjtksv6cf7mxzfO+w4AZRSgqS6D7wzjCe4jeH1TgTIbu9/
	 yXSwW8StjYEFa5XaQmS2NdWSXYpT1W+wEve48/0wJV+3MODuFPam7vQDWHwvfatbOAtzk
	 8av2aMR2iROTjjIRisIe6hzrjCfW3RlzJ+nhjHrZBN2wLPl/QnYzcYXqPiYVjiAUVk704
	 xyzjK8L0xX29S+2Ld6939DlctkhLcJy+v/CL8kR9KBGyNJaZg8ZC5i0WSisEaLjl96w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Gp3+oZfi;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E30606A881
	for <linux-modules@vger.kernel.org>; Fri, 13 Nov 2026 22:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E30606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Gp3+oZfi
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so2198789eec.1
        for <linux-modules@vger.kernel.org>; Fri, 13 Nov 2026 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608040; x=1795212840; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EfW5r72ztIVpTPsFjdHYnm3oK6ZY2qO8ZM5ubM8gZAk=;
        b=Gp3+oZfipAwpCv6RQBf3lDsHT0qEp1qD0xIU57NwQdPHacBufI3y/HY7/OzAFWbLjK
         COC86LQPt+kgTBoKHOH3z6liqUMbnRcvtWkBB8WIqiXDeiT4yGTVjFMACF1ENKsDRbjx
         C3I0ki9/tkmtjMMKA7wp0aKqDyg0qSYa2CbrM2wVKFsFljYWzj+9s9c16NYqeljycZwO
         iVGH7QDXUWto3Mg/o5+eK2TJvkhs9meOk57rJhHmcN6kCEqi48DpXJcEWMzNJ5yGHuUx
         jDmPg41tRHpFxTCOlMTfPNin1c89BrbkTIVqWmod8KAvcs1ZMcaLvN+715sxpWXF+n3Q
         1aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608040; x=1795212840;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfW5r72ztIVpTPsFjdHYnm3oK6ZY2qO8ZM5ubM8gZAk=;
        b=s6vJISy5EN8EzT27ynrzndyAgcSYRnIzmOLhKP4EyOEr+n8cMeDxqt9vLrRJ5MCLSb
         UrtW8maCF6EIYGvwQn7PicZ85mhcRCy/4yhp/Ptxmk4v3CdY/pi6MfLD33IOUTLZ4+UZ
         XFZIHEpgvyf1snAWELpxa0oxP9j5uzwMCQdxfMNOQp1KUUsvEnNbH2tMYy5hwE21q062
         n4SgDSJ2xtq8A3a+UFo3FOLz/LgZAHFBtB0F/v91y/0/Skx7m2u6SpIXdfE4BpUgZ7c8
         2Yow2DEmZe7OGT9Cpl588nJMKW5dOnU3vQLeXHqbWjXMMjSsjpn5vQ5VLFWhx0DAdxbE
         Etig==
X-Forwarded-Encrypted: i=1; AL+hErGlhx13HUAGGt/niT10rnlNgc+MuYUQ9QP+KpMI3OdAoOf3fSKHihbWLqGRzvIf0xhPJPZehjgh1ERmpP3w@vger.kernel.org
X-Gm-Message-State: APuU4Z9HmQ4p7IytAn7ExmM7rymYHGYQ0Soy+YJAUogps76mGdMatGcj
	ZRpP8lRj3DMYjgjRZfxZHco5VbpOcgK9WGSTlgObix6wa4M0is7EcPfqfjlOBR5NbulzHaQMTJH
	YIBodOZ6/3GwfVw==
X-Received: from dltt2.prod.google.com ([2002:a05:701a:c962:b0:1b2:3bcd:9068])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b88c:b0:1b5:58e:b547 with SMTP id a92af1059eb24-1b5058eb73fmr2722892c88.22.1794608039776;
 Fri, 13 Nov 2026 14:13:59 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:46 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-12-wusamuel@google.com>
Subject: [PATCH bpf-next v3 1/9] Documentation: ioctl-number: Add
 PROCFS_IOCTL_MAGIC range 0x10-0x11
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

PAGEMAP_SCAN (0x10) and PROCMAP_QUERY (0x11) use PROCFS_IOCTL_MAGIC.
ext4 uses the same numbers on other files, so mark the row as a
conflict.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index dbe462040999..fbc3537fc9ee 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -248,6 +248,7 @@ Code  Seq#    Include File                                             Comments
 'f'   00-0F  fs/ext4/ext4.h                                            conflict!
 'f'   00-0F  linux/fs.h                                                conflict!
 'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                       conflict!
+'f'   10-11  linux/fs.h                                                conflict! procfs ioctls (PROCFS_IOCTL_MAGIC)
 'f'   13-27  linux/fscrypt.h
 'f'   81-8F  linux/fsverity.h
 'g'   00-0F  linux/usb/gadgetfs.h
-- 
2.56.0.679.gc527c65306-goog

