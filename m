Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61037C939
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386619; cv=none; b=vBBkoQHeZfrGLyvpZzlwTdCyzxYDbxX8Kuc+mysKDPbN+ycym/D13rUiIwwOOQjMZtx9YBybCVf1CaocXhuFUvUX+2PYzCVy3ziF41J0vYlJ1TSmIx4vLffB0m/eWtmCc3jGaX7VC/YIgN2ejjiXSDNO/tmA97JYMrOAOP3D1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386619; c=relaxed/simple;
	bh=iMeRc73/gYUtj+wFwmFrIjzMyI0u1MTWAjfgzQHJESc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qgCFq6KSGRLejMz0x8O6f1sHI6p3LOR30KuajjCen+Rob7JCHtee7D7NLpX8y7IYTFY8T012J8751nXViRL2kCauVa9i56onrmUSA0WyTA8wv9VyeMc3D6cle7I63oNUb0ik3Mfq4Hhav+f3n3osAfT9ckfOdbsBRJnu3C2qgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cVh9xm2s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cVh9xm2s"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso92402295e9.2
        for <linux-modules@vger.kernel.org>; Tue, 02 Jun 2026 00:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780386616; x=1780991416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4sJ4er/vaqbbgesppHoOGKpU4Tkfb6XJ1iMzBuO3InE=;
        b=cVh9xm2snj9ak8T+mUhkZy2zYw8uwacIFimN6yJ9j0AvFkzCVtJbehUCzdBv5XINja
         rtj1lJkwroGdh8fPueUXWx70kLybUd0aXqcOZCm0xO0B3wsPT3O2lYPOzaFbAdqMU4tF
         VYk4tiFnPTdoZILwwf0P1w68to+oQ4J2Jh6mHySCMUWK+8/jvJkXVPMebhz2aXtdvq8N
         1pi5nuzkVzdzAOgQ03gcLUffFyd+vzdamLjZaaau+q6kbbofhfOSd/NFwx1461e7K9/4
         zcPTbYlNt4Z4gsLdkSqDl/h20GuN+Vn6ey38uRYgZFTdMKMgd25pxfICWzXUxK33XYMN
         E1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780386616; x=1780991416;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sJ4er/vaqbbgesppHoOGKpU4Tkfb6XJ1iMzBuO3InE=;
        b=n7DI8LZweys4I3kzfYXmWPsLVaYY915GE0RzAXSn4truYDIaKEuqdhXr4OFuT7HRAN
         +dhmL8tfyvmRsjhSo8Zo1BTbhzFBhSBgespFXpDDDRg9CCpAiFmt/+wqqgtjAXGWmMzF
         A8nI3bUigh6HOb2yS0WExi6ZXDdPCXxUNbFBfd2IDxEUCm4Bp4KrVYzEUExwSioPlB9z
         WosfffULn4Ug1EOub34HviIDllrOTAZT33IVsOJiqbH9YmryqsH30a1prt6Cv1Oumset
         d2L3+6OFCuF208aK/yV08pYpKsB2EAJl69Rg7l2siF36dd0ORl2YRnDZr6rviu+Sd0Y+
         VPlg==
X-Forwarded-Encrypted: i=1; AFNElJ8Aa7P7fD3gYj3OWeW9HHozwsD7fmYXKXsUqojK7GpmkErNY87DKsIXUFSaafzhWWf0gMAzfKKBi35IE4hE@vger.kernel.org
X-Gm-Message-State: AOJu0YyMw3HjcfZe6o+nDus4bNlGb9Q3ZMyKyzELPAkwW/RhqJGZUvHP
	UCNJyju8a53BVO3fiYegSqlJ1P3AFmd8WtO9ETNUrS+bf6VcqRgBv1u2Ng3hJrcCVlc=
X-Gm-Gg: Acq92OE/TJrkzxEYh6QfXNTgmLs4h1CCW6Hwe9fD5wPxxjTvWxW9CuV0CrBYqv5cjcc
	zmlnKkQGcAZA7OPlZfH0yTLekrSZoit3eC4vCru7Iv2yJGNvW5ZPsxNU08lqmLyYzITK0JCFXIP
	kSJfaZtOBSL2gJVFHCIkVmT5asmb/EaDlFUPYSSHz7Z+id7gUysRWBQMqRiYy+v/GCE/R0CQ4uf
	pZw1KeyGUczPKaA43Qa6eL5Vq1mK0KemUWqzNlUXn13iMxgH4U5cq9kBly2YRk64Goh8TdVEdTn
	CfLw1yD1FPviSugrCiPfLDOFQ7ngS5Zxq4knL5PhD2PpPK1hKcT+U+Sc4MRKlcyzzxU3OeECND/
	/T4uLDh9z0YPFD+fpEYyDC4c1yWdPTg8n71of4zaDsWXvq9O4fDje/RGwvgDR7pE4aPG0WuFgyx
	uY4yiCMFFMbvzCY0qUGZmwkvSHBQUCQxVVCzSrcYoqc6XsjFWUeIC40QUPKZmf5i4hAPpZyr6+7
	ipCZ7pkDbo4iAKZh6bc6G3CKpeHH3B+izsjDd5401xn/vOvXPyCHOHBC3aahzMRJw/uh88pwDl4
	i1G1
X-Received: by 2002:a05:600c:a111:b0:490:4b89:535f with SMTP id 5b1f17b1804b1-490a2915ce2mr197079285e9.8.1780386616065;
        Tue, 02 Jun 2026 00:50:16 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e0f26csm46866775e9.2.2026.06.02.00.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 00:50:15 -0700 (PDT)
Message-ID: <ecc6ed11-de1e-49b8-b6f7-1b6ae3af5e56@suse.com>
Date: Tue, 2 Jun 2026 09:50:15 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: dups: don't hold mutex across synchronize_rcu()
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
References: <ajydyxgaea27rhcopp5eauji24znotu65d2b4uw344yvmwcc6f@7l5re6f2xcuk>
Content-Language: en-US
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 linux-modules@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ajydyxgaea27rhcopp5eauji24znotu65d2b4uw344yvmwcc6f@7l5re6f2xcuk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 6:17 AM, Naveen Kumar Chaudhary wrote:
> kmod_dup_request_delete() calls synchronize_rcu() while holding
> kmod_dup_mutex. This is unnecessary since list_del_rcu() only needs
> the mutex for list manipulation, and the RCU grace period just needs
> to complete before kfree(). Holding the mutex across the grace period
> blocks all other kmod_dup_mutex users for the duration, causing
> unnecessary latency.
> 
> Move synchronize_rcu() after the mutex is released.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> ---
>  kernel/module/dups.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 1d720a5311ba..46e74c06ed52 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
> @@ -88,8 +88,8 @@ static void kmod_dup_request_delete(struct work_struct *work)
>  	 */
>  	mutex_lock(&kmod_dup_mutex);
>  	list_del_rcu(&kmod_req->list);
> -	synchronize_rcu();
>  	mutex_unlock(&kmod_dup_mutex);
> +	synchronize_rcu();
>  	kfree(kmod_req);
>  }
>  

I think the way the module dups code works with kmod_dup_req entries is
generally off and should be properly reworked.

This synchronize_rcu() call doesn't actually synchronize with anything
because the code has no RCU read-side critical section. All lookups
performed by kmod_dup_request_lookup() are protected by kmod_dup_mutex.

On the other hand, I suspect that there is a use-after-free in
kmod_dup_request_exists_wait(), where the code releases kmod_dup_mutex
but continues using the obtained kmod_dup_req.

-- 
Thanks,
Petr
