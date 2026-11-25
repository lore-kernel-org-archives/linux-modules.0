Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641932;
	b=dMo24530q5CONHOzakPvmdKg4LhlgwFoYusBtGaAUw7F3KmGOhT75hHEQ3i4iMBu8D/b
	 T9sZTu451Rww/Bvhs6nOBnZgBmU/6evcyfGg2sLUaaDqtKpYFLzRAvWblvygrjwhTRNhx
	 kEnVLoWw6wwX6n6JrwFyIIqswFAjzaXizAqm42INuoVQaKRwvrquAPmJxX0BwYUYqmRTB
	 +1NwbkFxfH3qJP1Pt5anAt+/rbf+O2Kajhj9Vs/BMR2qHwOTh+nX1ym+aAe6EElMffHrc
	 7xDh+Z2tPCxXchCRsRrfphrP1aXAYYUNoT/5m6rploqCWpgY9/3z9gniFXXXEOUUvLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=24/tAy177JKP0owGUloJsJ9O1cxGKyGsp+3cRmkz8Hw=;
	b=Ub51sawU3telttqbHy0KYZ7xLx8UzrYx8Hfo7GHXx5GyzNV1uP55MfpTbb7cQPkvP9lo
	 2hchyJwvSYxpxHdNO41q/8jGD1500e7EXwQnUOYpHOj2dxGKX/gDAeYTAS/g1rKLK8/+g
	 2vCdsCsKzczHJdd2g2tQeS7noKfztYRb8nXkgKswmu+jL2tWjA6KOa4D4q7o/qFIaC55c
	 VcjO2CFdc7OUEc7oY//4noWUb6qJ46oLbnRxAmX5y945luUERQhvqRgHSws3KJJ77A5bs
	 t6yPqIPOa9HIi0CY1myZEJ+gzNmlks6l6bNm4ejrDv05iB3dnedhlabKOoq7xUWAc+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RI0PEVo8;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B2606A32C
	for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 21:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F8B2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RI0PEVo8
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso34197765e9.0
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 13:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641930; x=1796246730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=24/tAy177JKP0owGUloJsJ9O1cxGKyGsp+3cRmkz8Hw=;
        b=RI0PEVo8e/bM5LpLPZ+ED0hsyThViRRY4VFXcvOC3yq8ssab9D3GWTn/NExxaMUXZ/
         SCEfAUzxIznLHW4X8Ux3FmsnGjVl8+Tu2I50vFro4UF290hC+aOGoCx3seQbB/Kkai92
         i2zbpMXrHM1e+hdoZw3s9g8KJwVNLFn1XzFiXMwhZLLCZapmock/E0+9J3LFHctwNKM2
         1wJUObs/t1OyGzg2ZnBNFqAphLTJMLH8yCwqrFBvoaxKN25zrCKYmaShH0vjh09I3jpG
         Uz4nqzrg6/yfBT6SdKciD9tyk2az1dmjbdzWK08Rn0x/RK7kdBz6as33XNA2CJWx8x3B
         BHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641930; x=1796246730;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=24/tAy177JKP0owGUloJsJ9O1cxGKyGsp+3cRmkz8Hw=;
        b=HdULAlSwmHj9PNoTREvOhsxPJqFKiE2bfL5IkKDD25ukKwJ8dP5JgUFhLBlr/T74EY
         kS7OMhlgvjUzZSaEJ1QvWIqZxBxVzj/Wd82fnWOFPP0YJk9CndjxnL5fKmkakNgndxNQ
         FGl5RQw2TwqdGAoomeRgXejmTPiUenKt0hOZ12zFIvbWa7Ol6VC971lmRG56QvoIhkvZ
         mSqp2B9TDUNSgj358g3Wt9v8JeIkeByw+QPowRvQP2QvKAP4keFmLhqDTF8PgR1auWZA
         xbEVIb1hGPFoQr2XYJ/52/VGvDsGJht81nrzLlNKZEGNvpTMlCmSwf++kgXV6pEHJVyF
         X3rA==
X-Forwarded-Encrypted: i=1; AL+hErFAjgA/NllkE+5V5lBsnbI//jMA3czPUlmahcEziafLbYVBndezOEIGUkP6Y4vahnkz2ADfZVt4UgRfR5Fm@vger.kernel.org
X-Gm-Message-State: APuU4Z8rb8B5OQjP+epKGYhnS/3lUbKDVBaa+4K85ed5AxFs5WUoLEZ3
	UhmX5WX+MWrB8HAruRm+y/hDwbfoLHV5VvGsbVoSYVmSV10mIRN+X2nP
X-Gm-Gg: AZFdTZdi9xZX/7f8gHm3gv+2xSNEF675Ufz0qvGRSeGz+rydZkqvIVPBs/8TmTz79dK
	Uzh6LUIcV2m29IXrGzv7J56iqGfSLfCfEKiHshbUicpjouqoKA5+yBVWzEjalOxwpOqVvo3va9v
	flNE5HnSuE5RwBY0PGGLPb3aziQDdfaqOT7YHnX9NqlCU3kRSwiRMfyj5qijTv5NdL3CLdtcUVa
	vNgrCc6eO4MIBednrSkIwc6/fseml+67OgD2fSW2AbxtCa4fByybGsahkeTphNTyJTCg+V9rv/3
	Lk6ssTGjeQ5pP6tFuJTzBYWiVNRY9Q4Jiv62rWM3rfJY18V8EuOwBjGqlH86fLPOzELcxZPSeQB
	vC284ia024Qlu2LsaQThI6LD3Dy5Ocm5Odw0Os+NwBZu5bTzC34JCj/lko0xPksRFXOFvNIiZ+j
	CFBv42UQLEnf4yRhZIguAdlX5Ir+5dETAQkR/9CwaxUaW5+paHmKHgbhO1Q56gXW6f4EQAWG1zT
	Xmrsg+Ct3Ho37r6ZUpYJj/04b/RtSPXy4IyXuYiGNFuFzx1eX09TXj+QyoeOhrDXPym8daaq0CG
	IPCIHZ1h6FhqeZL+Xy3q7djtpM8/0a6/txWXV+c8bY6RUwW/tt1oDHlb6mJ33ejpZw==
X-Received: by 2002:a05:600c:4584:b0:4bb:5de1:e90f with SMTP id 5b1f17b1804b1-4bb88819bcdmr380720815e9.31.1795641929874;
        Wed, 25 Nov 2026 13:25:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853c9170sm615777065e9.14.2026.11.25.13.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:25:29 -0800 (PST)
Date: Wed, 25 Nov 2026 21:25:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Samuel Wu <wusamuel@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin
 <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
Message-ID: <20261125212528.239ab6bf@pumpkin>
In-Reply-To: <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
References: <20261113221248.3535369-11-wusamuel@google.com>
	<20261113221248.3535369-13-wusamuel@google.com>
	<0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2026 17:45:36 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> On 11/13/26 11:12 PM, Samuel Wu wrote:
> > KALLSYMS_QUERY_BY_NAME, added later in this series, needs to find a
> > symbol name or prefix across module symbols in one pass.
> > module_get_kallsym() walks the module list from the head and runs an
> > export bsearch() for every symbol index.
> > 
> > Add module_kallsyms_find_name(), and put the shared query struct in
> > linux/kallsyms.h, so we have a more efficient linear walk.
> > 
> > Signed-off-by: Samuel Wu <wusamuel@google.com>
> > ---
> > [...]
> > diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> > index 1ff8ce857d92..72006c9bad42 100644
> > --- a/kernel/module/kallsyms.c
> > +++ b/kernel/module/kallsyms.c
> > @@ -406,6 +406,63 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> >  	return -ERANGE;
> >  }
> >  
> > +/**
> > + * module_kallsyms_find_name - Find a module symbol by name or prefix
> > + * @symnum: in: index to start at; out: index of the match. The index
> > + *          counts the symbols of the searched modules in list order.
> > + * @q: name query; if @q->modname is set, only that module is searched
> > + * @value: set to the symbol address
> > + * @name: set to the symbol name (KSYM_NAME_LEN bytes)
> > + * @module_name: set to the module name (MODULE_NAME_LEN bytes)
> > + *
> > + * Undefined (SHN_UNDEF) symbols are skipped.
> > + *
> > + * Return: 0 on a match, or -ENOENT.
> > + */
> > +int module_kallsyms_find_name(unsigned int *symnum,
> > +			      const struct kallsyms_name_query *q,
> > +			      unsigned long *value, char *name,
> > +			      char *module_name)  
> 
> Nit: kernel/module/kallsyms.c already contains a zoo of lookup functions
> with similar names. Adding module_kallsyms_find_name() adds more to the
> confusion, being similar to module_kallsyms_lookup_name() and
> find_kallsyms_symbol_value().

I've thought of splitting the file in two.
Separating the core symbol table functions from the /proc/kallsyms code.
Might help here as well.
The cut goes just above the extra structure the /proc code uses.
Three functions have to be made non-static, none are that internal.

David

> 
> I suggest calling it module_kallsyms_query_name() to match the
> kallsyms_name_query parameter and to express that this is a structured
> query, as opposed to a simple by-name lookup. It might be a good idea to
> similarly stick to "query" instead of "find" in kernel/kallsyms.c.
> 
> Otherwise, this looks ok to me from the modules perspective. Feel free
> to add:
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> 

