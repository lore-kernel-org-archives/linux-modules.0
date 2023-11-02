Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315A6FD5
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JN4nEjT0"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749DE7
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 01:19:18 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BF0EB3F6AE
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1698913156;
	bh=xOlOPXtFC14sPmMq/gNPsGSMRG8MAsaEPYDXA9iMskI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=JN4nEjT00TjHbWBdeSMPl3Ql3f9ZqUB6r5tqDGexxWoWyVmO13JcbaMuLtNcBz/NB
	 +ckNBAM/7DLnRetfsKfKVe4xm8zN62gWtB7aDLaIHty1MjDDTaJPi52Nc36NMk/u9A
	 1gGYdvkfsiJ+LIQidhqvlr1CZDwlvvx7h+I+pjMPooYt0vBg28J4go5cUmUt9SImrQ
	 qTHUSPMWBTZDgikN/cVsrKcAjmuONqWz2lfuluM6CRdcrCx+RzUOmwCg4cVvf7cEKG
	 7EkwBMEEG4fyr3MLQ5iFRH4Aigs0Q1zU2+05uixXmnhVBr+Ee9gD1Ad6qA1RqM+9Pj
	 DO409ITyPYgWQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9cd789f0284so41085866b.3
        for <linux-modules@vger.kernel.org>; Thu, 02 Nov 2023 01:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698913156; x=1699517956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOlOPXtFC14sPmMq/gNPsGSMRG8MAsaEPYDXA9iMskI=;
        b=rIc470ODAw4Lnu+MdG9yR7MTHO0qBhxophhozEsV09f+CHF5nz2PvppMd5412FYiEB
         euDyVn7L2wr4XjELcFkvRy+3WJplYPT3TGz7w4LOoGRCvmLTGL790gzCFbMgPOsA0JeO
         zarN/OOE2sVhVeBPw/qwy9nqGW3hlnGyMJ8gRinoAyFxWi6V0ULGvx6byRgMhuq+ZCpN
         DaRh9ha7n4AMGRbK4YeZJBYIzJ2kAxebn+tINXq9XoluGY1slra+NrPCTmll4EfO26ud
         UyKniBhz5GeZgjAhGXvvVPGdF3AirKT2lAVeZogFYZmDEtd2+yCCusxAOq0yqnooPeMw
         RFIw==
X-Gm-Message-State: AOJu0YxMzx2VMAAUmk+MuHpVBhXI16KyHMGEI3q6sB351MEUW+BqyIxP
	W7PfMgusN1hgEy1gG7jEgve2HHJjqKgovZ1KDQhuHuaLal/T3SsB2+Ye12kXj8G6VaWt5RkucoH
	48h8fl2LysxTRIq+0WqhWSe2a/ctG3l8TdrkNxzdldko=
X-Received: by 2002:a17:906:1915:b0:9bd:a73a:7a0a with SMTP id a21-20020a170906191500b009bda73a7a0amr2841635eje.58.1698913156303;
        Thu, 02 Nov 2023 01:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHH7IwIDgeKMPODTE0ZBXQTLEF6du+DVJY7/Nuswo3vcdrTQrgwmSzdl0XspVexrQnCQ+rxQ==
X-Received: by 2002:a17:906:1915:b0:9bd:a73a:7a0a with SMTP id a21-20020a170906191500b009bda73a7a0amr2841622eje.58.1698913155904;
        Thu, 02 Nov 2023 01:19:15 -0700 (PDT)
Received: from localhost (host-79-33-130-95.retail.telecomitalia.it. [79.33.130.95])
        by smtp.gmail.com with ESMTPSA id pv21-20020a170907209500b0099c53c4407dsm824959ejb.78.2023.11.02.01.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 01:19:15 -0700 (PDT)
Date: Thu, 2 Nov 2023 09:19:14 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-modules@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, keescook@chromium.org,
	zhumao001@208suo.com, yangtiezhu@loongson.cn, ojeda@kernel.org
Subject: Re: [GIT PULL] Modules changes for v6.7-rc1
Message-ID: <ZUNbgnCEXC92GLZm@gpd>
References: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
 <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
 <CAHk-=wi=goCaTm6ZOKzm_ztky9ZT-vuGDWv39vVdtQT+oW=zEg@mail.gmail.com>
 <ZUNPy/sMRxdo+o2w@gpd>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUNPy/sMRxdo+o2w@gpd>

On Thu, Nov 02, 2023 at 08:29:17AM +0100, Andrea Righi wrote:
> On Wed, Nov 01, 2023 at 09:21:09PM -1000, Linus Torvalds wrote:
> > On Wed, 1 Nov 2023 at 21:02, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > kmalloc() isn't just about "use physically contiguous allocations".
> > > It's also more memory-efficient, and a *lot* faster than vmalloc(),
> > > which has to play VM tricks.
> > 
> > I've pulled this, but I think you should do something like the
> > attached (UNTESTED!) patch.
> > 
> >                 Linus
> 
> Looks good to me, I'll give it a try ASAP.
> 
> -Andrea

Just tested this both with zstd and gzip module compression, all good.

You can add my:

Tested-by: Andrea Righi <andrea.righi@canonical.com>

Or if you need a proper paperwork:

--

From: Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] module/decompress: use kvmalloc() consistently

We consistently switched from kmalloc() to vmalloc() in module
decompression to prevent potential memory allocation failures with large
modules, however vmalloc() is not as memory-efficient and fast as
kmalloc().

Since we don't know in general the size of the workspace required by the
decompression algorithm, it is more reasonable to use kvmalloc()
consistently, also considering that we don't have special memory
requirements here.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 kernel/module/decompress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 4156d59be440..474e68f0f063 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -100,7 +100,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 	s.next_in = buf + gzip_hdr_len;
 	s.avail_in = size - gzip_hdr_len;
 
-	s.workspace = vmalloc(zlib_inflate_workspacesize());
+	s.workspace = kvmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
 	if (!s.workspace)
 		return -ENOMEM;
 
@@ -138,7 +138,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 out_inflate_end:
 	zlib_inflateEnd(&s);
 out:
-	vfree(s.workspace);
+	kvfree(s.workspace);
 	return retval;
 }
 #elif defined(CONFIG_MODULE_COMPRESS_XZ)
@@ -241,7 +241,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	}
 
 	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
-	wksp = vmalloc(wksp_size);
+	wksp = kvmalloc(wksp_size, GFP_KERNEL);
 	if (!wksp) {
 		retval = -ENOMEM;
 		goto out;
@@ -284,7 +284,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	retval = new_size;
 
  out:
-	vfree(wksp);
+	kvfree(wksp);
 	return retval;
 }
 #else
-- 
2.40.1

