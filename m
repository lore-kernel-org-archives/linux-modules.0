Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B863AB5C7
	for <linux-modules@vger.kernel.org>; Thu, 14 May 2026 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741175; cv=none; b=Q/ZDZ7eoAqmTingWDZTS3ckHKwQUE3DPlkoC697vS6rWUvTmNkWXadjmGCElfxKpibWJh5jQLVQbazXxpzkcsRFzTc3qfejf70XtUDU5JM+ur8V5DWoZO7mA5gRc+ME/UqfsHDXiqoTq8MHHayP94YM2VbszXNt1VHEDMNvr5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741175; c=relaxed/simple;
	bh=9WoMlXctnJX7VI6xy3gmdkzNlfWMOnxsDI0zmen0z7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dz9pINpJ/NwGgmy9t8yEfwb57VHXf5GFXzBvHuHQvxLeJQOdW+O36lsWVZwysGsEKpE+qZjadU7e5XHWinPvcNrfPnIr4Y6BHe59Jbtwf5Q0+QvvTEC9OXYOwgsmieFBQMWmnSjZ+lJ7up455s/VlPF+zQIgVGpfQ1ZFQRoS++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IlZcLVwP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IlZcLVwP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d77f6092eso4755336f8f.2
        for <linux-modules@vger.kernel.org>; Wed, 13 May 2026 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778741172; x=1779345972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLK4OFCAyAlL4axAHiV7SbqndCrWYl28zniYu6/O1QY=;
        b=IlZcLVwPk0RiNQPzap2NYz2eb9006clL6A1sg0iLk2XXRnOt7IHvIJQItGnw0NdE5V
         DYKejrcj/dmJVIbaS+HFJ+2Uz6v2/+IR1vFj0ThPr07+qGPUOWaNfBWUWgYOcqebVhol
         66J3YZu2gMBaRUqgUZVYE5DyyqoFHGokpj2mfg86g6WdExVcqn+wx4RQT/8qKp6pLQ3y
         JvkcSA9r3tV6PWKBHTxA7v/CySiLTEkbnfLbsVO5XON/5zjUcWm9KVhuGAUhsMHHtnnx
         RlZE8ZWn6nHaOrunKBSAYGrFwJFPCE1mseqrBTTHMLWqslwbil0FAf+8M5Y4LLwXj8AO
         z1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741172; x=1779345972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLK4OFCAyAlL4axAHiV7SbqndCrWYl28zniYu6/O1QY=;
        b=jf1+1qDKrVDTebYhEVS38Frht21ropaqvRkX14xLUwI/5yc4ps/trLLXbelRR6R8EG
         Q2Xo5I9FtAQKH1wHujpD3MsK3wAORUbfULxsGxr+/fdStJSUFxUHOzNzLiMlgiVY7pSo
         90eL/11bO8+DMNKGLcTcEuRyYVjW+MZpJTO80ygXSIDfTuhvWC7Nxg9vMV207Y0JYCdM
         RTj+AOFBJFY9NzqPkbgXWnmfbKqC/SztaCovVTas0ytGWYypnkPg15cwYw388TEHKzLy
         TOVzRO1E33yc5SYYLPC2wqM92qJ+2bjUARs6kyyZxRMPOYHvi4N3/2AHMYHe7FbDrzu8
         xOBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XVbc8O0sDME2fHRO4EH8h0ayQPBLnbRnzZL+CsdwwiXLIv39sLifz0VDqGjtRMQwO89AYtZ8ky5Fwvvpt@vger.kernel.org
X-Gm-Message-State: AOJu0YztgyyR7b69wQljQzlyczruy3tJIbOOsGymae852X68XRkbKvL0
	86UZdYHEs40nEuzbsf+EU9mejcZiVW4DKqOONN4YiClVro61xohnb6e2eLNW8P+CEZs=
X-Gm-Gg: Acq92OEhB9oPryeGEDN9Ttl8KG+d9kpoCszOqmbgOv0pzjiMzeHo1szx9CfoIQFblqC
	vLRbfLW6pFTvxJPlG26YOFHQ2nodoKCC3Z1PnM37OWno5IwhQl2Bd1tfeVD5GKVHWXEUzHcks8+
	+JfO7+nXPyfrsoYWGZ6JiUYC5RPVishkHzjLdYA6iSZacVUH2pRRlJM36sJTEFzy2TtOisPE+nV
	uaJ9WwoOhaFIHnQGJFkH/oQsgbnIPw9LkfZNoWyFajI5q8wsre3z67GStTzPJK/5XAPKNFZ2iwL
	V07pvKnIt0xcCQznd3Lw7tsWjah16rExLVcjRfwbH4AfS5fD/Uh15FLdQJv7ie/kwNnSv6+X6aC
	zoy+BsCtFSMlK3R/rAHG1yGRAvo78QUMCa4jsSUAby0HTpFhn/4JpKb/x8b2p+E8PVr2YWMY9Ts
	w3O63Dh3ReJt+I15OgNJVjbQJCjxthJHZxMyECdUi+RHyK
X-Received: by 2002:a05:600c:4ed1:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48fc9a41e96mr88986265e9.21.1778741172397;
        Wed, 13 May 2026 23:46:12 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm4465330f8f.34.2026.05.13.23.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 23:46:11 -0700 (PDT)
Message-ID: <29fa0ff2-4477-4b42-824f-c99d862786ce@suse.com>
Date: Thu, 14 May 2026 08:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
 <20260507-asm-generic-1-v2-5-47c52759d268@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260507-asm-generic-1-v2-5-47c52759d268@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 10:40 PM, Jim Cromie wrote:
> With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, several build configs had
> problems with __dyndbg* sections getting lost in drm drivers.  Fix
> this by following the model demonstrated in codetag.lds.h.
> 
> Introduce include/asm-generic/dyndbg.lds.h, to bundle dynamic-debug's
> multiple sections together, into 2 macros:
> 
> vmlinux.lds.h DATA_DATA: move the 2 BOUNDED_SECTION_BY(__dyndbg*)
> calls into dyndbg.lds.h DYNDBG_SECTIONS(). vmlinux.lds.h now includes
> the new file and calls the new macro.
> 
> MOD_DYNDBG_SECTIONS declares the 2 BOUNDED_SECTION_BY calls, but wraps
> them with output section syntax to keep them as known and separate ELF
> sections in the module.ko.  The KEEP fixes the lost section.
> 
> dyndbg.lds.h includes (reuses) bounded-section.lds.h
> 
> scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
> CODETAG macro (consistent with their placements in vmlinux.lds.h), and
> also includes dyndbg.lds.h
> 
> This isolates vmlinux.lds.h from further __dyndbg section additions.
> 
> CC: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> [...]
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index d9d2eb708355..54897d742c6c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -332,6 +332,7 @@
>  /*
>   * .data section
>   */
> +#include <asm-generic/dyndbg.lds.h>
>  #define DATA_DATA							\
>  	*(.xiptext)							\
>  	*(DATA_MAIN)	

Nit: I suggest placing the dyndbg.lds.h include at the top of the file,
as is usual, together with the codetag.lds.h include.

Otherwise, this looks ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
