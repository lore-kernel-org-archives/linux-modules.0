Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CA1CAA8D
	for <linux-modules@vger.kernel.org>; Mon,  7 Apr 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035280; cv=none; b=ACEfkLms+NLhvXazdubuh5583Y7G9Xp0f3VYTImrF0dkyT9W10RJZfeiopcOv9tNhOADoZHARyd7G1r4qn/erLPei+r3SSI3KIAF47pgSfTcdMTTdpS1jX+NrR3jgbjUNJts/OgzlvXVyjoMF7FgvN8bSoEUjjNz/AJD9esOj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035280; c=relaxed/simple;
	bh=GQArtUB6gCNUMkL83HMpvJlYZwJql0yUBupjif7ZGak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMo1/OxJslEb+h068LAN2o9ohJKFHwYh4cQAJz1NcbCiWShrN6W906AuFeEEJ8bqwCvlfnfxtk1asPBmTC2Wt8mJnjjzsvC5KDa1QYALlYCJAHTjd6EsRXGn+AoUJwZNBn5gQqhNWzfujE8A7LXm+QhDGY8hmlgvA4NUHjOhyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=drcJQ9Hz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="drcJQ9Hz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so41221505e9.0
        for <linux-modules@vger.kernel.org>; Mon, 07 Apr 2025 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744035276; x=1744640076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtxPoMiwi2zSOTSOjpjQSX1tRQki1Xeprd03zQbP9dI=;
        b=drcJQ9Hz8S04Mt91GHUzknmKhPAEBsKh/0UHvRSs+GFCzKjB3I9pLQzngCJ5tG9xOz
         bKiTCRSJPHC724wQnmqMWWUu5GOUgHJ2O6MFz84/CWNhg/k9wzOwwP4kS/YoWkCzRIfV
         DEMdDTZgC7Dfk1gdtp1u1KuC5VyBujCivoyGWLWvDmuFO1wpyTQSsPbR0pZE4MdpPkzr
         HYwuSj9oW33Pg1al9RPOCouiFRPfI8rferUhjpK0cumVXtXHQDwyYL6Thcma7+v7/5nf
         w3FNLcFskN83tz92VDOzqUBC5saWJ14akE2LO1ZLt12/9fMe51ozsva/N3ZMufouLRKb
         Eq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744035276; x=1744640076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtxPoMiwi2zSOTSOjpjQSX1tRQki1Xeprd03zQbP9dI=;
        b=QxTG5B9OUmwbygPEH+J0hHm+oemr3GOeJl9c5MVHQtB/kBF4DeC9vWg/eU26ThMB13
         +ZlwxkO+eow3Vvp3fxBvLzd+QqW6qj6gBGTtKLwa5MaFEFW/We0oTq4b/bCK0F1i24aH
         QMFJdS781Sxawwdq8vk3icwSltBQq6XWMo3GoXg7BAO7IKIfc93HiIo+1uuBZS+lwbcv
         vx2s7BxoymAmZLL+v3lorj+1Lc6vYRIaDft2yuaU0S7Yq4EZgOKw9+vtyFLioa+mUQWq
         aRSpkZ4VXqpFVJ6uGPn77mbSlii7cEeuARZkNdndUgwdHcdZQ88YEy+5bTUYFH/6iWNH
         z9Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWfpkohD5QTYZoTMPHJ0+3Pl6rY/5gb1/yACBmngpEGwA+Ir4KOb9gDyzZqd12ipz70P29NUq3F2+ILbjQN@vger.kernel.org
X-Gm-Message-State: AOJu0YwCc/jmy+BTGIZ2PiWFsM8ZlyuZMPo/o7cpxXZ50t00DYF2oAkt
	gSNv7dWCyV3BKOmfUqnyN8M6dYPHmc0Bp6v0r9NonWKKa/v1kXCNDa9GFSJJQrQ=
X-Gm-Gg: ASbGncuchUlJ/IdWKNtg3LxBzItNhPe2wLC7exwTRRoncg8oTxjJvsynGN/W/0OC3Gw
	X3N6ulL6T8otJ/6tSk/ud67pCc8eiGbX2cu3F9ABgumjUXF6T1OMTcjI/IPG0BlIYsRUEUCMoNN
	SqH8ViafHaZvTzrT+COZeNSYQMR4C4pilB89nxP2bRaxblLMImTIGae6F4//8oBXmvSvsuKlhNe
	ZoGMSmtxDIc7ANhf2Q6mqGAwpx7dW3ThMgd1zg/eO1Wm0oyQ8/DOB5nc/bD9gDqBSXmcdX0NyHn
	njQc+H0In7GHG1NyMLnF4PjPqW2lQ4XrY70AiURoxsNz3OY8
X-Google-Smtp-Source: AGHT+IHDA9BzZ1Chj4rRxu5Fej1PRG/jtdH0WBKyf55PHfts7unW3vUtQLAglw7Ovgjzdlsv/V2h+A==
X-Received: by 2002:a05:6000:2702:b0:39c:1257:cc28 with SMTP id ffacd0b85a97d-39cbc73213cmr7202015f8f.59.1744035276349;
        Mon, 07 Apr 2025 07:14:36 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7045sm12385085f8f.39.2025.04.07.07.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 07:14:36 -0700 (PDT)
Message-ID: <fc5a960f-21d4-4110-88db-20c103491af6@suse.com>
Date: Mon, 7 Apr 2025 16:14:34 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] module: Make .static_call_sites read-only after
 init
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306131430.7016-1-petr.pavlu@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250306131430.7016-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 14:13, Petr Pavlu wrote:
> Section .static_call_sites holds data structures that need to be sorted and
> processed only at module load time. The section is never modified
> afterwards. Make it therefore read-only after module initialization to
> avoid any (non-)accidental modifications.
> 
> Changes since v1 [1]:
> * Rebase the patches. The kernel now has commit 110b1e070f1d ("module:
>   Don't fail module loading when setting ro_after_init section RO failed")
>   which addresses a previous problem with handling ro_after_init sections.
> 
> [1] https://lore.kernel.org/linux-modules/20241223093840.29417-1-petr.pavlu@suse.com/
> 
> Petr Pavlu (3):
>   module: Constify parameters of module_enforce_rwx_sections()
>   module: Add a separate function to mark sections as read-only after
>     init
>   module: Make .static_call_sites read-only after init
> 
>  kernel/module/internal.h   |  7 ++++--
>  kernel/module/main.c       | 18 +++------------
>  kernel/module/strict_rwx.c | 47 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 53 insertions(+), 19 deletions(-)

Queued now on modules-next, for 6.16-rc1.

-- Petr
