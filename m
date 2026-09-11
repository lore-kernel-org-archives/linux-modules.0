Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D1346A14
	for <linux-modules@vger.kernel.org>; Fri, 11 Sep 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139419; cv=none; b=Fnb7VyicdBUrXQYpCtG+UykAUNWBXoemMu6YDu2B4QhMRPsfKbgbAkCLk1wA+DpShONiSwq1ctXX8DtEeLB4vfmU3Y19i48MJrf3V/9yHy5twbveNZOFwkLIKHMovXVOH/rJOan71sRPj2Vc5QqBtP/sO9H6ZBGNe2nBxbyqbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139419; c=relaxed/simple;
	bh=mqiwDcKpOaRNus8j/Fg3j0JoEM5rH/wkoPe7vyjGseA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+dx/ZkJzUP7Y2T5sE6rSfjHmks2EtrtjD8MNNBAVH6GmaerN0YgLNGZlOhNw0b+2u2mubu3FqD3rFx36lBiMV37lkMyO8+uAQgQAbY8VBlpb/IV0JMD/KbAnsEpm5e9HBAXdPSBl8logJH8UAS4vj0nrm1h+CXO9MsgYgIdQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=kK4G/F9w; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="kK4G/F9w"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7fccd4c3f36so885113a34.3
        for <linux-modules@vger.kernel.org>; Fri, 11 Sep 2026 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789139415; x=1789744215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMKSvjVBgJtd6CjrRqlh3dJgvYQUN3eoWH2kuKct2qs=;
        b=kK4G/F9wPPusW8S1G4rXbeFmBv+/IN48Euc/NhlP+M7DENbx5tgQNCT9J3oNAowLsx
         ugow5y7Oiez1bisxwk6MJ2UIRxoPG5gZPnQYO5mCqAAwB5ZjhTKjRtSJs92RM0yZ+yt1
         CJq1uT7goVyNFuQ15NS/hMr4b4T6bt3YCeoRlMJFQ7IEqkHbZ4NJhB6NMfJqRVLD1Czk
         9QzeEZ4YV7Q7JCuFCRVKamzfNym6sf3Y8yL7V3kKj5ns7po0oiAUVN2UIcw6SXz8dO9C
         3U3VoEuO9qcaMhml2ivm5wRn5w9ISrpjEa5184/d9LUBlicwmSuLk0s6OT0CZ7OZ/T/e
         9zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139415; x=1789744215;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMKSvjVBgJtd6CjrRqlh3dJgvYQUN3eoWH2kuKct2qs=;
        b=geKhD8NxQJoX8OLNMZ6Q1kPHsDdHv0l+7/K0YWswS3kiQmOdyPdgCIbA08uB7oPVdB
         nIDms2AA3M2MeKBUNoeo5wHibxrkzKoC7VO/VF5nx+Iy+UYNvtsZSP20EZF7u0IrsZHO
         vGzt4GXNoIarjGJ1flaOtlMkKgHhGdvL8owa7sJR802w9oOjlso5QpnHy/zEyIl/5N/X
         OUwEAchkY1MdGmpZ1vFQlIGONN31GHGseFDss1VmJrW7YJZXZjkyrsHqa/39Prvx5qMx
         0eSF8umDhEgYrcAAXPAedM+jNdQhroWxNjP1Em4KvytmyHAq7TY15V4lDxJzpifzIpVs
         JZcg==
X-Forwarded-Encrypted: i=1; AKwUvBzKgniQLtclsaqKfXPQFHExfWBrh3JfqESrqjqeyuKPUUKfkuRQcaNSlFAFygBkqi+hpKqVSVG5DoxXbFpZ@vger.kernel.org
X-Gm-Message-State: AFuF++k+qH87/MBc/rZrxjSaHvFgORMq2MO5oFBxwc/numaTI1OAAVz3
	PYxifglFUjp1til2en9TOX+G8eM5TP/+jQcpAc1Rmh0Gw/+Z68EKHrcNwqi7G/itinM=
X-Gm-Gg: AYBFou0OWz7EKGL/HFvQyW5ncsIrqRzXaitp/DRM2senv0myci9HtxLFagb0u28P6Jf
	wh67X3js6r0hFo+uuz6SD7VrskjgsZpctDwbYMyUXbW1q0ojTfjLdrgUeovG8EmS6P0SUbpFZNO
	RJjFE75m558Ke9k106FxfzkMVD2JZU03ZcHPjPgGljxzyb1YKqTg2FsCj5xRHGGsaRhKXqqvaSZ
	4NfwmJ1AM6K+Fv+7NF/pokZV6pOFWt0QdkKoVvW60cyWit8qT02qyrxWOqgYz9dOeay4GZGUXC2
	tiHvcJHi54PeXsCe8KErQKls6F1ufYcHtxDLEMA5v0OgXbqz4OqOSVhUQac9I3TQvJpAHEM4laZ
	+1iRBCtv3NmYpJzhnRbnT0gRmm8SbWf8oBqvot1Q6BtGu+3aHzQPAZdr9rywX+wc2tJRIxEfAyw
	I5UOBqZZAx+tiCXB4w2Nm15dJoxHDmnO945VEf17FBIfu5FFeNh+DmBpMMb/9gs5TD+1F+YO8ro
	4trATtL+Ki3thF22IZQCyfhZQNobsjc25fV7v75NH+TRh/QQyYWa5FV
X-Received: by 2002:a05:6830:82c3:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-803fe1bd730mr7936240a34.2.1789139414671;
        Fri, 11 Sep 2026 08:10:14 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f6d1875csm2548656a34.22.2026.09.11.08.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:10:14 -0700 (PDT)
Message-ID: <258d93cd-a18d-4860-bab7-2c9c7d43a015@kernel.dk>
Date: Fri, 11 Sep 2026 09:10:12 -0600
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] block: Include error-injection.h for
 ALLOW_ERROR_INJECTION()
To: Petr Pavlu <petr.pavlu@suse.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Francois Dugast
 <francois.dugast@intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-block@vger.kernel.org,
 netdev@vger.kernel.org, linux-api@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
 <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 9:04 AM, Petr Pavlu wrote:
> block/blk-core.c uses ALLOW_ERROR_INJECTION(), which is defined in
> asm-generic/error-injection.h. It currently relies on this header being
> included indirectly through linux/module.h -> linux/error-injection.h.
> 
> Add the missing include in preparation for removing the
> linux/error-injection.h include from linux/module.h.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

if you want to shove this upstream somewhere else.

-- 
Jens Axboe

