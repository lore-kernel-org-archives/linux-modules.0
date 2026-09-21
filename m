Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF9492E50
	for <linux-modules@vger.kernel.org>; Mon, 21 Sep 2026 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991719; cv=none; b=lVk3dGcF1XqUk/Xcz2kfrty56E+g+sNT6aWkah56aPeJ2Ab/3okKka4MR5cMcRwQaSnG4x501Q9vgBt3EZp3IFqaFX3Dm83jQL57gQ09o8XOodL6dIC1Xf365XRSEzbO7zF9uelcOQwEb4vFbBkGSrYH2l0MbEjUtLq72Yf3hvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991719; c=relaxed/simple;
	bh=w0043UFoabFN1idwysUYX/vETTsf1aFbar1G7lykZx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdLgyri3pjfFM3v3dybjW2L2QfeYTJ+ACza1i2W5Zkc3N4YWO6fS4Qa/JWdXjfrMMCTaGbK7QBYTZ5zhALSAzehj13s8MTkovRe7JDzfKXnB5UnvvI/uaKp8dOQqVwrR3aQrTDRrEAhafSjlryOvtNLOyXKzRk4bdTqXrxSLsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WS6Ei1L+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WS6Ei1L+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso20861835e9.0
        for <linux-modules@vger.kernel.org>; Mon, 21 Sep 2026 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789991716; x=1790596516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoGx0ZyZW8wnp5QELsj35eexSkwzaTvnMBYC7KfLg74=;
        b=WS6Ei1L+793kk57RUzfW66Aj+uKd7LjiOa/s8f7lCLlksQFesVCwYsKg7gbz9PoNVJ
         ksfQ9E4goZ+9nuf0jh91rIP+Wm5HxApPQ875ru6cOwt7tYJqy3ZbIohmmJgxU2YFqvZf
         AJDlXMcICsbCoP28puiRVm5Pm54ufLAf221v9kxc8xQvHCqCGfDX1eopwycQ5L46fHrt
         j+8KTILdtJOrY2hijT9UHkeWFZg8OUxFYatZlZEGU0/Wf/Cst8aw1RYsLw5kegkWipDg
         6RrqI3CBQ2ncjAz5vuLhT3sE5+gzwI2Q52O86G8dxXsu0cd5WCd/cBTdb9BHGA83UWh4
         430g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991716; x=1790596516;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KoGx0ZyZW8wnp5QELsj35eexSkwzaTvnMBYC7KfLg74=;
        b=Yn1nYqiXUWjhnD+TbuaOCGGhRlW1bBmUcw+9HJSllV+ibRexthI8PDdpgyeCMW7U3g
         vitLie+ZiBUTBA5Qgz2pk9bTjP4oVeHGIQqhnLKUyEywijQX7ZvzslGm/JUOQoDq896g
         JLOwClqbqHG8WPGrZn5DgIJBjaFDkVV5dc7oItIxdNWgGdyhiUgL2plCNugaLtKgHh+z
         JZDSsKkr+kmrLHYu6CdIOXnmGv444aYTL9O8EIJiMS9aAkfbDpIfyoW7bUx7kGk/PyR/
         I/WIPdeClbDyrhtQyKMJs+gJn/9vLRbeQvkQQHBbOj696ovZHIYUKiwnDGmdW7Ug46Bh
         QSSQ==
X-Forwarded-Encrypted: i=1; AKwUvBzT5pMGa/EwJjwYIX5sAiBa2XL1pIBxIISfOdU8i+IAqB25u0ePJFeWt14vPf61ImViUifm6o2v9CfD5YU1@vger.kernel.org
X-Gm-Message-State: AFuF++mBjukJHA1qr12WD380mo+kzfrJW1lgxSwDrrdnYKzGEMQCXVHp
	tl+7sB0QUL3NX+YaX/Li/+eguvZD/I36fyBOGnKLo7rVVrAd5iCsaJ3Ts5j43KNudo8=
X-Gm-Gg: AYBFou2iiYpULk0SFOiPyAC+JEHrEktWsQ8tYHIgaH6pHSv9EpxK7N19vcu1g5qNJhv
	UaBaPDiDboSZpU2YbZfOzE0cpcLNNVi/cyp3eDRhJ7Mgx02tRXpY67xMFNQTi/T/NW+mzJT4q57
	iBv5feviq3o1KkfOKp1DZh4dN7h7ys23DzJ2CazXGdQjbF+8tnNwIQu5m2+2PNgLP351B6S/PXU
	pFse23rlx6DuC+BZRvqcJTrF/WM9WSwG9Me4+bzTHaR31TX39+VfcZWNsMTX8rkiersH0iCHnKn
	64vRZNkmgk0zX3SXHcPsmX6z8zFELQUMI1Wd4AgcNDLQQo3vPx5LvDK5djuuOB3mfiBy7WhPms1
	uKj2zFskUghLRdC87vJki95+KjTbSQRgJduurzg4fRGm5QjtHFhYYL3WKiqzRy9hgHj7qoWvVr3
	NkPYahDJRjuec0JxWRSDZ0b++BK7sqUz9Wf4aYGYjEBTqqm1x1WHcXSCvc0HziLBvLtjZqXDirO
	zoLGBORok3HV237OHPtPTL7kt4/FqTwB+L7H7dSk/Vxpw==
X-Received: by 2002:a05:600c:4e4c:b0:49f:bd3c:bc28 with SMTP id 5b1f17b1804b1-49fc574f456mr149078405e9.35.1789991715929;
        Mon, 21 Sep 2026 04:55:15 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eab91sm244798625e9.1.2026.09.21.04.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:55:15 -0700 (PDT)
Message-ID: <d771ad48-9f75-4ca7-84c9-04139afbb7d4@suse.com>
Date: Mon, 21 Sep 2026 13:55:15 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] modules/kmod: Allocate argv with kmalloc_array()
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
 <kees+treewide@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260917211229.i.604-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260917211229.i.604-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 11:12 PM, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> argv holds 5 pointers, but the size was taken from the array type
> "char *[5]", which would make the allocation type a pointer to that
> array rather than the "char **" being assigned. Allocate 5 entries of
> the target's type instead. The resulting allocation size is the same.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> kernel/module/kmod.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Looks ok to me. I've queued the patch on modules-next for 7.4-rc1.

-- 
Thanks,
Petr
