Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348502;
	b=moNgLfmOch4FyluvoSy9v/6zRdqt8+rr8zInAJCpWMvSBk1Sto+1ZnUcgpg72UQvGXlY
	 caor7b0BH2i+Ck1gUwSpS60wWvkpn5lGlG33J0KYjSoQgRjN90D/VtrBscBPK9uv0SI3U
	 guZKG3+lt4KK4TMyilf77MD8BqzNW5KnmKzzx9mXlOvoP2wYrtyfq+bvG5UUJTYpNV7qv
	 VEeUueHbQ4TsjMdkE36FP2EX/e1lhlD4pAoZQ/Retf5B3ZLNFkN3rasHVcd7K/oLZY47S
	 dM6p7P/kC9C0AdFhPAGKUKXNqEW5Nj2PCi7qkovbn/hhorpkowImuJZiW4NNq36KyaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8c6qVyqNZ0SqHcZpSnANumyjBAiFjdYDHk+HUxi2Enk=;
	b=mnqar5EaBxQQ/X6XueOo1UbKGCRCEkM/59cDFO2Jp0Z8j7FgKIRnErMA00jFZFY0kS+p
	 QR+QZ86ecpNyORMYv3qcIqQT1l37FOisxMeOpmLC6mtbV4Rq/t0h1E4wIisEsSXCxc2CH
	 IiFGjp5gXnVmNPP7rdEKzyy1Za8jMU7a/uXZlI7twI3jK6bEoWyUFmDPfnrZEjReZlQGV
	 HlVUcRtJi7XNMK01e+N77VJgqh1/IjuWPHXIAfHrdrIpa75ECpwrIRmKSguYKU4aqQP04
	 ufNZzrbyMxFDRpS5/blB6A7vCA+jfHOrq8k+n6L6SC4tTblOCD2lhcMZy78xl2KGolg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zdk7RKsm;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC181606A32C
	for <linux-modules@vger.kernel.org>; Sun, 22 Nov 2026 11:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC181606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zdk7RKsm
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b467581b98so21222845e9.0
        for <linux-modules@vger.kernel.org>; Sun, 22 Nov 2026 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348500; x=1795953300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8c6qVyqNZ0SqHcZpSnANumyjBAiFjdYDHk+HUxi2Enk=;
        b=Zdk7RKsmohrx5k/Al/SkovQbicu1EKXI37wI5NynMo18Bejrr9QqTge3LQUQFo4NaJ
         QShG2NRTlhn/pNf25M0pWVJck94Kex/RP6CnG8t+3Kzl7yc2Jo89ONSbSqPw/K2XgINc
         kyGcGB48KSKmJjUd+3HnNauJKhZJtQscJM2p+uPICSuBOQscn0vA3DS2YqdDXgnCIlXf
         eD3TL9LlSjCG1+MPO/RUF8otTJL1Dq7lCfFelnFxSHd9+ijeDWBdCouZxwAD/Wbqp7cD
         35PLtNOXBbDyWokVwrcgFG7sYlGWvNZtD9Hj7BblPU1I7FakYLUJ1YuJ52qDUVZUY7ha
         YMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348500; x=1795953300;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8c6qVyqNZ0SqHcZpSnANumyjBAiFjdYDHk+HUxi2Enk=;
        b=r5tfTX1wm6kZvSUEPuLy2qHBbiVmTVFFUhAE0P/SoAb0ui1cegbuAh96LbKXQ+N1YX
         fCdkz6Y7bg3F0xdQIaoBEIwjM0UPwcUDVmRPyZzUAy5Ljl6N/yLUUdzeW0AfoQ285YRk
         Al1J96yCPiG6djsRsYa1iV834BtgRYjKx1IMUApUjERa5at8CXO9aJdunJXv1/Ud/NZt
         0JS1JUVXaxZq9/de2RiRuCHAyEhISRt/6FTxJqmKpWAHZeuVodVTN7TpsVrjq/D4txO9
         c4FfSnu6AVuw7axrYhbATZlAh+fpUSC3bptkEsgzc6BwxicxmlAD/goT1gV3JveQu5vN
         i/ew==
X-Forwarded-Encrypted: i=1; AL+hErGpU7rsj0TwcszGBbQTnMqSoX8Qb6AznJiewORTGoO604TSSPIcUNgKVP5SxWjqUwA+gAU+5km0+oCpoe3A@vger.kernel.org
X-Gm-Message-State: APuU4Z/nVxizW2ow059vtCLYwb8pLh807pZjIR8EkUEtEmGaSGD2lIkc
	Oi8ZUHf4QnsnUQHnTzwl5Ns8VJD+184tbiFQ5BcKMvPdtYknxR9MY17L
X-Gm-Gg: AZFdTZeIpOEGwnybJ2tt3TC1pULlQwg/ayiiug1uSXoCa7Z7AnM1P4mIke2baCVPhhC
	WjSlk92pXbYLLQkQgo6kwanGImhwoBN5IhEcjzpUG/JxtaK9xDzDHtyDER49AVs3tw1BWAtlLhn
	IuuygSsp1fbjZQdWGWEXTgISsP2vpKnNgLk6DpltF+HhjvDBjcecusfTHUM9hLVwj06/T8xzhT6
	fq0RvetmHGVfe3qVOvPCQ94RkNm6oiQbqcR8bcsdoQes8l9v0qAQGVN23xwWmhTOLsAuBQ/weUh
	v0SdAbhEjbv/Y/TPZXaQDv5GhFBFtSZzS7igZr5m8uGktBEMyGDDpIbXzTiqbl6mPVLKp48ItL0
	6w2FBjvkytkV1C2Qd1AZ80slrY+g7Nqxx0EAB0WmnzOm7LMzaH2MxYOlwu6xURkzs2d1K8Ytlk/
	cWxtOEmuTsG6jqJ3NHQ9/edgR2VCtmHV7ZE3X09Ha1FWIktymfpF1fJysMn7Df9cVMPoyy/7UQf
	VOIhlubOUjn0D4pS8I6/nnWKqQYgbZu7UNAYDWAtPf/KKEn9uat+qzJKDoY72VIe+FYO2gKZ8rG
	6X63JwnCMfimO3UzBNd8wknsgLFSrlsSab3RpeeV21bfsxgBIknxePHgrrzoX1QwQg==
X-Received: by 2002:a05:600c:6092:b0:4a1:d537:1c8d with SMTP id 5b1f17b1804b1-4bb8892bb67mr166647795e9.19.1795348500044;
        Sun, 22 Nov 2026 03:55:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm168516455e9.2.2026.11.22.03.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:54:59 -0800 (PST)
Date: Sun, 22 Nov 2026 11:54:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Cc: jim.cromie@gmail.com, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Andrew
 Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/6] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
Message-ID: <20261122115458.1da4b8e9@pumpkin>
In-Reply-To: <20261121-vmlinux-lds-v1-2-49818f3f5cc0@gmail.com>
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
	<20261121-vmlinux-lds-v1-2-49818f3f5cc0@gmail.com>
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

On Sat, 21 Nov 2026 15:49:20 -0700
Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org> wrote:

> From: Jim Cromie <jim.cromie@gmail.com>
> 
> These macros are unused, no point in carrying them any more.
> 
> NB: these macros were just moved to bounded_sections.lds.h, from
> vmlinux.lds.h, which is the known entity, and therefore more
> meaningful in the 1-line summary, so thats what I used as the topic.

Maybe remove them first?

David

> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  include/asm-generic/bounded_sections.lds.h | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
> index 8c29293ca7fb..268cdc34389b 100644
> --- a/include/asm-generic/bounded_sections.lds.h
> +++ b/include/asm-generic/bounded_sections.lds.h
> @@ -18,19 +18,4 @@
>  
>  #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
>  
> -#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> -	_HDR_##_label_	= .;						\
> -	KEEP(*(.gnu.linkonce.##_sec_))					\
> -	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
> -
> -#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> -	_label_##_HDR_ = .;						\
> -	KEEP(*(.gnu.linkonce.##_sec_))					\
> -	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
> -
> -#define HEADERED_SECTION_BY(_sec_, _label_)				\
> -	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
> -
> -#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
> -
>  #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
> 

