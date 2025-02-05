Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036022A80B
	for <linux-modules@vger.kernel.org>; Wed,  5 Feb 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750478; cv=none; b=TT0sAxrk9YHJiDWb8jH5itUqmPVvGNLTgakKDIZRMBHt2kKCBV1wuJ1Pko5FORngK+sH6RTWAQxWe6ff2L5NIwtIzmUmL+oOmKlncJiGgQc3OtBgwSt9+YBNgFIR/7bwCIxGqDVSM3PZRMG9WG/W6NDxPnDEXHI90XRTvmqA1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750478; c=relaxed/simple;
	bh=cl3s2u4k8LqaA7VoeY6ZsMAhGEyET2LwEcvJM2G729c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z443itIbCOkfBz2PELVmyOd9gkl2fUtkUSebaMkNsoCYNiz2poGZMk3vSpIq75rr5G6KqklU74Fk+wCgvFl7DGB6KntYLQ1zOpX7hhXGAS3K4sewpaDXQZBPb9IPi/fh6YWgjWOkZ7xxQaqdm/yFMXlA/Lmh+ZiCtFujUjEtAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VhePItP0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VhePItP0"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so75395825e9.0
        for <linux-modules@vger.kernel.org>; Wed, 05 Feb 2025 02:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738750474; x=1739355274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TpE+w64W/w0pZz2iY3aYODrTAmBDToH0rXVM/D9B+U=;
        b=VhePItP0iFUehcJB8Og+OGWbacraWABzNa1xFhjuTDP1+Hs7zLEvdgQ03uWhP0kG3J
         VP9f3+36uaDMpOTbl1qKA8xN0qB/vxFRN52DqzZC1k2j1Op9q2FF24jP2qJTpFrleSCL
         8TlikM9jGiR0f/+G2xG7BlMZCjmPFt2d91L1YZd3/t2t+WlSHc16hZv8HOwERhhk7j3h
         AKGAY6IahTjLIERzBYb596D5/f8tSNZhgcarbuJlBINx5R+i35JpgSxEhZCbDh2oJyfs
         4ZPk4bC/x53Lauo7QH4xQyplnJdzar9gKo4LBAnI/MGW575jhqQ4aat3fqQzsokxWLnr
         DdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738750474; x=1739355274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TpE+w64W/w0pZz2iY3aYODrTAmBDToH0rXVM/D9B+U=;
        b=MiTGHwvPuckRQcJzyUQrJ4pDhTTfv6ktC18SRvI4/Co2U1l+MC16QdKoOfE4hAo7PW
         HIuHWFZ6vSoKp+Ez8cHdM4/6Yb0ZTq7ez3tGr96YCNrbPMaXVXftVIUzBR8ovpyXQVsD
         SztBBT/yNiO73bjuH2nVvOOJxXrCVFSgqM+MR5raHva0o6Tn0jbVWpTOYuKxQwwch5O3
         SvWWWzGuLJIqFmrFL6Br0rhUQ1dDuqB25eMPywkZyYkXuDuBVtmiYv1l2HWa+qdpYnat
         CQRR1Y0h7CMqZq5gDDRsuW06NmH7xNKQDikQ+yI8S9LRCX702S4ffBTzv0F49MjsWbHO
         vnXA==
X-Forwarded-Encrypted: i=1; AJvYcCVZdgSpvWkfSc5/zkVZ1uFdVqKNkQIzlUZearWExbp5/8yHS15k5e5/sx4Ok5UU6o9SjS30YS0TnbaOJZA8@vger.kernel.org
X-Gm-Message-State: AOJu0YwyCn2GBoTvSy9AYiFYyP0yZGGgeIMtm1D8hhX3RWzw8n4Ne2Wp
	xBu+Edz9cmF/tl6yb5kY99snfNHxgH7odqdtGkR8E647hhJnOwRMDrk0M7iz6zs=
X-Gm-Gg: ASbGncvkZtE2BPA7clrs5R3pIH2YeLnBzAhhtZZbKompyHRMfQyMDtgJtPlyOPVhk0h
	TXOVmd5nmA1tjFTJEnZh7aWauVtc6KmJ373wLSlKWIR8t9xY/fspGRfyV43XgVl77BA3tQnkO53
	1NV54esXjyE5Rwx2gG5YCWdYYByXv0hH9vrefaGT2MQzKnfiENV8TN8phfeFczkm5tIVy5INlzX
	Gx9Pjw6LNlZR1Z7R+psFUfarsBtNc8Ul+eBSAixmO86H5enBpt2lY+2Tf5EQfN2OXgTVTAEOy4n
	TkwsgHO1PyOztgquqLY=
X-Google-Smtp-Source: AGHT+IGrKqVhCP3AqODgr/FPITUVbZ9hb54g8ST6SnNmmjRUjIBUB7Ppw2hDlDy1xMw/NeyEYRNS1A==
X-Received: by 2002:a05:6000:1208:b0:385:f72a:a3b0 with SMTP id ffacd0b85a97d-38db490d6b2mr1196407f8f.55.1738750474338;
        Wed, 05 Feb 2025 02:14:34 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dac5a3e79sm4267717f8f.63.2025.02.05.02.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 02:14:34 -0800 (PST)
Message-ID: <b35737df-01ed-46a2-ae67-e56547d6c824@suse.com>
Date: Wed, 5 Feb 2025 11:14:33 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2 0/7] module: Strict per-modname namespaces
To: masahiroy@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, mcgrof@kernel.org, x86@kernel.org,
 hpa@zytor.com, samitolvanen@google.com, da.gomez@samsung.com,
 nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
 hch@infradead.org, gregkh@linuxfoundation.org
References: <20241202145946.108093528@infradead.org>
 <94bf84a7-13a3-4701-807e-fc0f10d4dc88@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <94bf84a7-13a3-4701-807e-fc0f10d4dc88@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 17:43, Petr Pavlu wrote:
> On 12/2/24 15:59, Peter Zijlstra wrote:
>> Hi!
>>
>> Implement a means for exports to be available only to an explicit list of named
>> modules. By explicitly limiting the usage of certain exports, the abuse
>> potential/risk is greatly reduced.
>>
>> The first 'patch' is an awk scripts that cleans up the existing module
>> namespace code along the same lines of commit 33def8498fdd ("treewide: Convert
>> macro and uses of __section(foo) to __section("foo")") and for the same reason,
>> it is not desired for the namespace argument to be a macro expansion itself.
>>
>> The remainder of the patches introduce the special "MODULE_<modname-list>"
>> namespace, which shall be forbidden from being explicitly imported. A module
>> that matches the simple modname-list will get an implicit import.
> 
> @Masahiro, I'd like to take this on the modules tree for 6.14. Can I get
> an Acked-by you for the changes?

Ping, this still applies mostly cleanly. I plan to take the series on
modules-next, or let me know if you prefer for this to go through the
kbuild tree.

-- 
Thanks,
Petr
