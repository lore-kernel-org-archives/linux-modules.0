Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47BD5013D1
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861871; cv=none; b=QppWmW+xKiY1u2qDsHPnGVfoXkAQRdDMbB5Tk9YnoYyG0jx5ZEF+CCj2rc5qLAV47wL25erUwGGO3DcpLmHY0g4eU9FKUcXYowMjzjJ4hRYRlSYVnTfspQQ30yA8gMP/4EHuhll4N/hJNWApDJsVXwZnxZ3UEkMrTXSvCUtKYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861871; c=relaxed/simple;
	bh=GTDnFhKJr9dcCymmLZx43u0kYHqfR/yMp3Bs8Hr08XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1RhEfTh5kmk3XA53LuI5n1bIEctDfblJX3kda0fGgoGDm/Xn3ftW22cwkbLyXPMJ7wynR8Dj5TjbxUZegOvhcJ+4Lxv2wLkTo6z6ZsM2KpVW3YvjcbeAbyPLodQuPDnb1ZoiS/inJ96+QMTLX22Lb71N/ehkbpBli+N/bfYeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GnoUn0RF; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GnoUn0RF"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a022e9cbebso4615105e9.0
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790861866; x=1791466666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdpqPvVclhD887soSbD3DxkHY24ueUpkBJecYlWBIIA=;
        b=GnoUn0RFIaFy6+Spji9bdPSxbDLqd6lWNrwm+d+D/ccF6jRjZPCwHOaZPVXUTRurdp
         ChO9eqDA5GmBHq6+Gi8oJSTKligIIWshsFVQpwfBzCfqsiVb1YUfdG7PD1iUEX5DuxBb
         W6YxFg5wjJCg5DC56ImX7nNN7yDRYxNK8orofUJm37zIe96WDrvfHHPwPYPqjDUbywlM
         aBeT9KuAqnKc3DCP6jbM+76VtKmPMABJnZG0lDXGQ3A62DVlnafcCDbKRLpYj0gvVLjn
         segPG+l2cF1NdPglR84ra/8HuE5CdN5u41gc5TgfIT8/W9VyT+2xAQMu024nMntJsrYq
         DwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790861866; x=1791466666;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdpqPvVclhD887soSbD3DxkHY24ueUpkBJecYlWBIIA=;
        b=dU3WYzpXhxG9oCHbt0NJwCBu7+6Y9WEZf9VGqB5FhEI1JHoP0F+YO27pT2RtdCT0wM
         kIkB5wLL7RclPUV9SAxxqAKj3ygxs88MPZi4gzNYtmcAUuBT8Ai1HpxyM3ezP/ZHN8mU
         cgzMxgL1DFSrwowhJZkAyx0f3yYqQcGLG31nu6KwjVeDIM4oW2UpM8OnJoWKmVLT2bBx
         /qtNY1U9CzQ0xlxIT9Jk/30Va667xKOZ46zV6VJXHJe0xEPKHRDgWPyhx2pbP41QoIPu
         aYVViYcLQNcVtjliBHxdJaCswR9KS+ZbRuSiWIOWGdsO4wiCplxo53at8QTCiohJfctJ
         d9PA==
X-Forwarded-Encrypted: i=1; AKwUvBwzSqEc5g4xqw9mKWncuVwpNv7eSn+6NEHOR3KQEuO+tD/ELFOxzQc//2bL9e6GK5KfxTZRlDfBYXxucUj0@vger.kernel.org
X-Gm-Message-State: AFuF++nAVJmbMIvQYQzn77rDqa9hY3q5Xmd+tVLQPRb2+I/LBNLD31lL
	X/yayJaa3fiUGwviX+JOpAW+7+CcXBrooyC9Trt0+U2zy6ekZYvoTFAz6aDAfP/PKnU=
X-Gm-Gg: AYBFou1XFiuyJGhnV99SCZN5U8b1a5s16zICqAaHHcGVC4VJQt2If5V9ycrtjKiymI2
	MogvAy1MV8w97XVf/njeoo44fx4O23FPFJ5MrMGmICBVu7U9vGoJLrKVhA0QjBSJZ9znSheEV8o
	uIb0yxqV7QFPIdlUhlb3w7yOZiHteZoW0m0lA+NIuSf9teOr417c1dDSgihtLhWRnMIiL2aojxO
	h20A6PyMjC+3Ba37kYbwH3uESgkVmRn7AWpCueFL4iT8EWIUJjaTlo/sXJmRYjzBuleyyUbf98i
	W+YEn32kz/gfOuIfNdtUvnddE/870bgz4HOuPDtoK+Y+A+XboQujfiW4VkXI1DRiEvNQaCPHPYU
	6t13Ui6I1FYvxRgA3dX7oRIq/DyUPKAeUXjs9+YJfsYNnkjGedy2k5rjvpJhHqjcUU/vJZ9QoYr
	pSELPBRYZ1EstmkJfFqOoofvajJMy2Qn+5c6MoW3UaV3EBaO85yQCFniAS8jhZXKRwC/W+X3ry9
	5xKYw6XSjTTUkt4BNC4mE8+4oTUWbHMywQ=
X-Received: by 2002:a05:600c:45d3:b0:4a0:e45:e8d6 with SMTP id 5b1f17b1804b1-4a01aff0bb5mr71387835e9.13.1790861866411;
        Thu, 01 Oct 2026 06:37:46 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9851efsm78627845e9.8.2026.10.01.06.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 06:37:46 -0700 (PDT)
Message-ID: <d3c7f66b-3853-4822-a7f6-2e60d54a20ab@suse.com>
Date: Thu, 1 Oct 2026 15:37:45 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
To: Gary Guo <gary@garyguo.net>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917051147.98775-1-tweek@google.com>
 <DLHERMQ9DOIC.1TRR4M82WNLIZ@garyguo.net>
 <0ecdcba9-a0a5-456f-8d30-e2201828cd07@suse.cz>
 <DLOERNFT9KH0.E6BYORP7OCZM@garyguo.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <DLOERNFT9KH0.E6BYORP7OCZM@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/26 2:49 PM, Gary Guo wrote:
> On Fri Sep 25, 2026 at 1:36 PM BST, Petr Pavlu wrote:
>> On 9/17/26 9:20 AM, Gary Guo wrote:
>>> On Thu Sep 17, 2026 at 6:11 AM BST, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= wrote:
>>>> Module authors may have non-ASCII characters in their names. In C,
>>>> `MODULE_AUTHOR` allows arbitrary string literals which are emitted as
>>>> raw UTF-8 bytes into the `.modinfo` section, and multiple in-tree
>>>> modules use non-ASCII author names.
>>>>
>>>> Originally, the single `author` field permitted arbitrary string literals
>>>> including non-ASCII characters. When support for multiple authors was
>>>> introduced in commit 38559da6afb2 ("rust: module: introduce `authors`
>>>> key"), it reused the `expect_string_array` helper that had originally been
>>>> added for module aliases. Because that helper enforced an ASCII check,
>>>> `authors` inadvertently became restricted to ASCII-only string literals.
>>>> Later, when the macro parsing was rewritten to use `syn` in commit
>>>> c578ad703ae9 ("rust: macros: use `syn` to parse `module!` macro"), this
>>>> restriction was carried over by using AsciiLitStr in `authors` type.
>>>>
>>>> Change the element type of `authors` in `ModuleInfo` from `AsciiLitStr`
>>>> to `LitStr` so that UTF-8 author names are permitted.
>>>>
>>>> Fixes: 38559da6afb2 ("rust: module: introduce `authors` key")
>>>> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
>>>
>>> Off topic, but I have a question for modules maintainers...
>>>
>>> Does the `authors` field still serve this purpose today?
>>>
>>> Almost always it is just the initial submitter, while the code has been subject
>>> to many changes (many of them tree wide too), and the maintainers could have
>>> changed as well.
>>>
>>> We have copyright comments on top of files, and git for checking the file
>>> history. What's the point of keeping his inside module metadata?
>>
>> MODULE_AUTHOR() was apparently added in 2.1.18 back in 1996 [1], with
>> a comment that it is for documentation purposes.
> 
> I am pretty sure the kernel changed a lot since then :)

It depends. Copyright lines, changelogs and the MAINTAINERS file were
all present in 1996, yet MODULE_AUTHOR() was still added.

> 
>>
>> I don't have a full picture of how this modinfo field is currently used
>> by module authors, maintainers and users. I think it can be useful as
>> a record of all past and present primary authors of a specific module,
> 
> Well, if they're actually updated... But as pointed out that this was usually
> not the case.
> 
>> and it has also value for external modules.
> 
> The version field has value for external modules too, but that was recently
> removed. I don't think we should care about external modules too much.
> 
>> Unlike copyright statements
>> and Git history, the information is directly visible to users through
>> the modinfo utility.
> 
> Hmm, why does the user want to know who is the primary author of a module?
> Users shouldn't try to contact the authors anyway, they should find the current
> maintainers...
> 
> Even if the field is perfectly up-to-date, a user running an older kernel should
> still not use this field as they need to contact the current mainline maintainer
> if they have issues.
> 
> I just find this info to be hardly useful at all.

It is fairly common for software to list its authors in an About dialog
or in its documentation. This information is typically not used to
determine where to report bugs. One could therefore make the same
argument that such information is not useful. In my view, it simply
gives people credit in a more visible way. I think the module author
field serves a similar documentation purpose.

As mentioned, the author field is optional and individual module
maintainers can decide whether it is useful for their modules. If it
should be removed, I suggest removing the uses of MODULE_AUTHOR() first.

-- 
Regards,
Petr
