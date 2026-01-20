Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5340F8C7
	for <linux-modules@vger.kernel.org>; Tue, 20 Jan 2026 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911473; cv=none; b=WB6LQAeEhZigJECJGdlvei69auCMDM79nzhfv7R3+TsMVwFOA9UPdBVCNvPLPeQSlWZqMwhb9vnIeLf43jz9vQBJtoO+FiMgOiifF4FMsAM5jwtmg2ZapEcc70cHNGRzglg0KWIqr5QDLCaB9E4+5kSAvnNHyxhQJTeRF4cKHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911473; c=relaxed/simple;
	bh=iIuzik8f3PuL5IiD05JYvutWRTw3mpzpbRggsiY4kB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQRygGD/xxguULNEVmzTO0+si1ctyv31elVadX5HBSm5Cx1ixq11VApVBEfNjLVzkn7UVNoXgRllByJo9eVMTedx/MOB4popDG3fH844L5xqzu/r8Gk5XTeqd1iMorCTkLWEkqiSZmejggWCf9AxJgtHSZjseLQP0d53VOcwhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=boq31eZl; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="boq31eZl"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43596062728so115827f8f.1
        for <linux-modules@vger.kernel.org>; Tue, 20 Jan 2026 04:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768911469; x=1769516269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJRswF5rrqok4Sjk5jUvdiR7sS5VwezMU3Ml3c2KzVk=;
        b=boq31eZl0sUGywf9IH6qctlquE+MboocMi5kXOESrth2/RLFNyNekK9Yz2p1Dm4t9q
         pzPu50oo+ZQND3pYlw9dqv/dzBtad2jjkOxqOgH5zj9JdQbt4TzZMQ1CL+5Y93Ptb+la
         e68NZCwT7H95F6HnUMCIbzjTX4lYBvMufaKkpt95DH3x2a+wlmkPFq6H58XsYpvNyLRD
         0iudwmABr3Nnsdhy0fiTlKZQETK2XdxsXMpqi5nnrsk1w6Ug3pY8EG8Pk3MwB9OS2Aud
         +3stOyreBUDzcd7CQMyvNzeCsvA6aeAxsLN5gZFf3huV2+gCBGtMMGAOJy97nuT6HP2Z
         +toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768911469; x=1769516269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJRswF5rrqok4Sjk5jUvdiR7sS5VwezMU3Ml3c2KzVk=;
        b=HGaH6zN2sghXoioiB2lMa2+tU+7CRlSlTT5zFCT23xC7FwTxUPuXCQ63K94hqLcoP6
         OVjhY4+OW12c6utbX8pA+36LTA789JFUCN0p4vB/NuUK28S/ALvkSBqBy9VSevmBAGqR
         aWLynUGXsHgXLC5bfU/rkGI2vqzO9n7ae8HGHTUzsTclVXlB7YhYJ6f4G78iMLFO/Gc1
         /eesra3dTg/baNyCyoJ94s6dTe+Ni0k/uf17Sk4ldAP87LMbqFUI7fdhxJlGZ9bag0e2
         3Qf85/jHeSAI0Jf2I1jZYUKlYUi/FUCvcgNU8YzbFoiLHei7Itb9ebvGGdVLSPcaIunK
         raUw==
X-Forwarded-Encrypted: i=1; AJvYcCXusidyh9P2IMLkfXb8PNnr95l96/5iQPJlCwyK3dXFNLRfbJW48GYbSK4BK0ptuVnpDkmUuFZjQFEDxqgZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwmjydmU5yKaocfwo1Qf/Ksk2cuKixgEoXNZ6+w3NEFd3/HLbeu
	y9meFPczl6liKUoyHQYTPkIn62bAkTjIbcCewe/sheQKrRR6pwf/6lTqDZSxTr6694A=
X-Gm-Gg: AZuq6aIjwFp+TC1RoXp8JkoNvE1zx95HSKKOL9IZeEnD/Sj++XSivmsnficxUfqqibD
	ZAjkTf8q139fN/YtgXd2uO96Hbyldaa3SrBlJf8lxisZ38+EXHI6aehiCBwBH2AaB6IVmWfrvfd
	xoXWvzmbr0o1zii6ntZQtRL3nKAUyywSUtM02xMaWMIKF2JXvDE16yiYK3PWF/Xr4sCS//zmT/4
	EudAIaSGijq/DJJNdN3U9zNT4vHfJhzljy/Zz75psOXMzaM54i2W0JkpSCeqmI3nlgP9HveioD2
	2xotg6z/dLIjr0JPOrSkM4RcGiDVyw/AwFoWbj/RaaTJhINUnfIrt5ocy3Wh0YKinfOmyQQxM4c
	E9XD2nRzsQf8Kj3qJkrFiXdURhssDAtinrsoIwj+ioBGyn9ILVxSLyA9x4+VhaaIczBmlu0omg+
	1/3Z0WrEFABqAjyFjneMTeabiGQDPv5NlMg3lnZsw6
X-Received: by 2002:a05:6000:2387:b0:42f:b555:5275 with SMTP id ffacd0b85a97d-43569548aa2mr19948618f8f.10.1768911469374;
        Tue, 20 Jan 2026 04:17:49 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm29657069f8f.32.2026.01.20.04.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 04:17:49 -0800 (PST)
Message-ID: <4d379736-9b6a-4e40-ad67-53ee7498759c@suse.com>
Date: Tue, 20 Jan 2026 13:17:48 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Documentation/kbuild: Document gendwarfksyms build
 dependencies
To: linjh22s@gmail.com
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Sami Tolvanen <samitolvanen@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260114-documents_gendwarfksyms-v2-0-297c98bd62c6@gmail.com>
 <20260114-documents_gendwarfksyms-v2-1-297c98bd62c6@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260114-documents_gendwarfksyms-v2-1-297c98bd62c6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 12:47 PM, Jihan LIN via B4 Relay wrote:
> From: Jihan LIN <linjh22s@gmail.com>
> 
> Although dependencies for gendwarfksyms were recently added to the
> packaging rules [1-2], the corresponding documentation was missing.
> 
> Document the required build dependencies for gendwarfksyms, and
> include a few examples for installing these dependencies on some
> distributions.
> 
> [1] commit 657f96cb7c06 ("kbuild: deb-pkg: Add libdw-dev:native to
> Build-Depends-Arch")
> [2] commit 5bd6bdd0f76e ("kbuild: rpm-pkg: Add (elfutils-devel or
> libdw-devel) to BuildRequires")
> Signed-off-by: Jihan LIN <linjh22s@gmail.com>
> ---
>  Documentation/kbuild/gendwarfksyms.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/kbuild/gendwarfksyms.rst b/Documentation/kbuild/gendwarfksyms.rst
> index ed366250a54eac3a72c2f529da94a9e803704ae4..0e153d13b052da6edcf65950739730c123cd49db 100644
> --- a/Documentation/kbuild/gendwarfksyms.rst
> +++ b/Documentation/kbuild/gendwarfksyms.rst
> @@ -14,6 +14,29 @@ selected, **gendwarfksyms** is used instead to calculate symbol versions
>  from the DWARF debugging information, which contains the necessary
>  details about the final module ABI.
>  
> +Dependencies
> +------------
> +
> +libelf, libdw and zlib are dependencies of gendwarfksyms.
> +
> +Here are a few examples for installing these dependencies:
> +
> +* Arch Linux and derivatives::
> +
> +	sudo pacman --needed -S zlib libelf
> +
> +* Debian, Ubuntu, and derivatives::
> +
> +	sudo apt install libelf-dev libdw-dev zlib1g-dev
> +
> +* Fedora and derivatives::
> +
> +	sudo dnf install elfutils-libelf-devel elfutils-devel zlib-devel
> +
> +* openSUSE and derivatives::
> +
> +	sudo zypper install libelf-devel libdw-devel zlib-devel
> +

Nit: I suggest slightly adjusting the text to something like:

"""
Gendwarfksyms depends on the libelf, libdw, and zlib libraries.

Here are a few examples of how to install these dependencies:
"""

.. and swap the items on the pacman line to 'libelf zlib' so the order
is always libelf, libdw, zlib.

Looks ok to me nonetheless, the list is consistent with similar examples
in Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
