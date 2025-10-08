Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E52586C5
	for <linux-modules@vger.kernel.org>; Wed,  8 Oct 2025 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929765; cv=none; b=Gvpf7SVMd+KPNwv36Io1PUkbeEK6T6NFhBTyU/IIsC5olSxg35/Fdt5/A+76yq2bi9VrufJZPPWncwU39IHN2ucLNbl90vsr7JkSC8ixko2w3G4T+b46xgomTOot26pR1KAE8c2X95tqK9DKVUN537mubP8Hf67/pVtAsByZZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929765; c=relaxed/simple;
	bh=eC0mq9CHz0uy1+c4DF7V23DakyvbvC8nry8GMoB26yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsXcAnncIJpDRtkL4ujTEv7y+fJxIbNKXlPeUaze0jGh2yWt6OrnbhlBzV8kcEf6fltuG2ut82XJUVNG7NBnAZgCARBakX36TcI4MuxE5QhL35oIsLbt3o768b2n7EgnkC709jh9FYJS64Kk55MDijZfUraomgv294hWuBrIk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=graURhaN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="graURhaN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so70173845e9.0
        for <linux-modules@vger.kernel.org>; Wed, 08 Oct 2025 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759929761; x=1760534561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4U2xsHoGJTH7iHhQZXfBw8CarpzUw6iPe1T3ECE3xUs=;
        b=graURhaNgwJllCwU5YtDzDBBaSmXK3PBdOWI7RRmfvi2gysAJ5ppbQIQwgE00sYE8c
         UXnsxRtZzi6U8L1XbwORYaRWwh7H1sBbmACIiD/7yDA+IquarGI22YxI4iWJnCwXDbmA
         RTV4y9d3FHXdXz4aM/OhW2voQkJhtYYdBvIUsNBAbhjd6eFARG5+wvoLYh6rrIwYo8Zt
         ptFxciSPzXJ3NvOBQDSUzLZbLTv14QEnIneM+nLuT+cM42gf5zk3TG7mXJO87WaizOJ3
         pDeuIa+c55B1OZSeh/Un4DbgQfH9aixL4txAnRAA10LgrhBJ60jqDnWP9hofrb+EsA8P
         dJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929761; x=1760534561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4U2xsHoGJTH7iHhQZXfBw8CarpzUw6iPe1T3ECE3xUs=;
        b=PSzE1DxnhYe1mpyXg7JkTb8pI8EPYxmNmg4+FqTkN5Fsy4BaEtbYdlcbCbEjQ1x7Jh
         5P7wSP9G+wFNqDnqHH79NSd8NqfPgxEiqyi1bBLx/O+zRIy8PO1208iGt2mkJxPgS0Rw
         RFzY2r162qIj6m8Be61OkhoDDAsBA8NxF4NcQpWyv16IFyyG0X2VhxWNbFSnWz4hQCRR
         3+8xXS1XtMt9+r2OAHU3axrChV4CHdk5vwSbFRgO91XyF4EhAvvNnd2Z/wAHvnRfkPF1
         LoXhPMKGwSso1Brn/ckUMCtZR0Dv2EEOLubyFpLibwR3ShUVo8ilaQb4pYF5+PXjzB+J
         oZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUUJjI2Y303+c8Y1AEFQQyeHm690WZ4sDVI3+k5PAL0HTfGv3NG8AzCJ+Mz5JNfIufvtHs5FFgdLwM4tbCP@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7PZRZ3cwX8uDTPZrl8xqwwoI6TeJI1LQ90CHcFb64+v9B5tV
	vmznDVP6FF/bOJ32pabZmd4CjhhmT3tToGosjNEUOQtsGA4KGo3HVGAav76I7CKH8V0=
X-Gm-Gg: ASbGncu+t9/7XjkClGccsjwQ0rLkeKyoOv27EQDx8CXw75Z9G/5JJjUZ2yhqA/qGFJD
	Qh5r1mg9Cs8QRjZTGAtKKdMRObywe8s/cV5c7Z8KnjmzZqN1+er4hcScxiRW+z5o74d8qBZf44p
	+5rUuX40eiqAiJAkJ+ChPm3PNcpaMqynnHUYnUqnLINFB9IyhreM3kHtFpNqS8ZEHwhPP69vfdQ
	XUYdJx2hM+c81ObB1QJaV2uHJaxXj+ID7EXKkTPGrpgtIiSz3LdmN9i8T73jhUbw4iuT35j9x0p
	zqx5QMr8vv9WCQJrJge0RfKNV/mIXZEY4XFA4GKeRBUxprOuF5j0PW5pWINKWRE3cExmUX83Wqa
	tqi7I6/wNMTG6Yu93/P9WVnlfFuvYqFNCbtYSpz/zupi0SpavINYzZiWMhr4w8xva
X-Google-Smtp-Source: AGHT+IEYSq0TP4pQ8Uu0J6YEh6RVoGDJ8QoABxOaZSJ8G000FXcsdbuhJ1AnUVCmEjMI85B5DM4SOQ==
X-Received: by 2002:a05:600c:6212:b0:46e:27f7:80ce with SMTP id 5b1f17b1804b1-46fa9af8f39mr24232495e9.23.1759929761358;
        Wed, 08 Oct 2025 06:22:41 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c1726asm37099255e9.12.2025.10.08.06.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:22:41 -0700 (PDT)
Message-ID: <026b31a0-42d5-4f9a-8604-70f85cf203f2@suse.com>
Date: Wed, 8 Oct 2025 15:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] module loader: remove references of *_gpl sections
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-7-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-7-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> The *_gpl section are not being used populated by modpost anymore. Hence
> the module loader doesn't need to find and process these sections in
> modules.
> 
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
> [...]
> @@ -2601,10 +2590,6 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  	mod->syms = section_objs(info, "__ksymtab",
>  				 sizeof(*mod->syms), &mod->num_syms);
>  	mod->crcs = section_addr(info, "__kcrctab");
> -	mod->gpl_syms = section_objs(info, "__ksymtab_gpl",
> -				     sizeof(*mod->gpl_syms),
> -				     &mod->num_gpl_syms);
> -	mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
>  	mod->flagstab = section_addr(info, "__kflagstab");
>  

I suggest adding a check that the loaded module doesn't contain
a __ksymtab_gpl or __kcrctab_gpl section, similarly how the function
later checks if the old __obsparm section isn't present. Something like:

	if (section_addr(info, "__ksymtab_gpl"))
		pr_warn("%s: ignoring obsolete section __ksymtab_gpl\n", mod->name);
	if (section_addr(info, "__kcrctab_gpl"))
		pr_warn("%s: ignoring obsolete section __kcrctab_gpl\n", mod->name);

-- 
Thanks,
Petr
