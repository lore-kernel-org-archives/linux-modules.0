Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6F395240
	for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269068; cv=none; b=jpX/3HEAU5a6e4D1vlZHlZqLxYKpJu5LTEUWpjxhJLLK64YGfXGW/2kny5z1d1QpQMtKRzBu/4uws+2b/pURWmYNXBZ+P5qLIvYdQw7A6VxUi/DuJxMyAV/wtgxalmdjPzQtAvj4k0JwCHl+rld7dUbW1uSHbF7r8QzkCD3hYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269068; c=relaxed/simple;
	bh=mqovvhK1aHJtE1FXWbHRZbczMQz1tYtALYdGIWzno1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cddHVAD/UNAfq/tL0Wz2D9RLSsA+0BpQHfnYdNQXIVjD4iJ1e0PkcyOFEaqWPlMSAc9S2ByIxd4sBuuzTdUG7OWOh1GKft6UeU0R+a8fX0kJf8h8Y9n7SxtaQqdTQFLnytGLrBbsR99JOJJWRTnimXaMa7UAiGTsz0orDxk3sPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHg/Chq2; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHg/Chq2"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-126ea4e9697so1986c88.1
        for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 15:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773269067; x=1773873867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENEw4lCC3j6vIuqcozSOUgOwZUIpv+glL+Ofm4fta1Y=;
        b=hHg/Chq2GL98QXWQfCflTB/jog/ciFWZe9YJYg1QlYR/+kce6tzPF/qer5Aa1pxX/0
         J+2Gvbg+ux6P+6zvrlnVXgwDwS6/PNdMKeSPGScO09pabqAYVuyMalctHsvKfFYoyZ72
         G0rB1eogBFN4omOWhjJm8nUBTo4bhOCkbPiiNZ382HbWEVkzi1sROxoBGLGcXZgLPipG
         Nb9XwzqNCKgySIvr362UNovFjypcYQd3sr07eq6po+NhncXNL0n6n44JhTQSn3V6ipqr
         phbzCBNjkOVdi2x0pmAXHB5+T0RZ80YjgVHvZNZOIxGWM8H6g5Y++wMf6IOUPTbUle/R
         d/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773269067; x=1773873867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENEw4lCC3j6vIuqcozSOUgOwZUIpv+glL+Ofm4fta1Y=;
        b=Khp9KxovyHyOxY97cJqfGcCxWoMqp+EGfiQ8X0f3u3pceujsYDAYXEqhOKlPH2hC7w
         C/T2R2rk4MyIKftMRLr37yR8/+/DR1R/ltsD71vzgG+yT3ag8/BDQqVXxDOJsVVpadfg
         oemAqQPgDOHZ3Nqyd//BByQD2IJ9uaEVNsv9YZ+P8xq8/He9Yo+bkomKKOUreYfGbwMo
         qbUg3VWKEDnjXwia9Kh+7vo4UGxFXwSqi0dbaQtNMgVpaYEMy/Pd0AnaR/81TDhHJepn
         nocq6/NxdjBp/dP1e4Rf3bs4YEoKgfgTMXi4FswLE9bTbjRgfjROuNrxJuS7N46BMEDY
         PQJw==
X-Forwarded-Encrypted: i=1; AJvYcCVH8eYGTHqS1pCVCEe6cdCyciRnp2FYjH2cSIAH32hcH4JhBAWmp2MjCdK8m8Kfxw9vM4DJ+vxIYUI3Bo6G@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuv1t+8R3BDe1U8fY+qmw4RfEutwcMcapZwe3UuThh3P1lthzq
	BGtlqWfUGX91m4/BcQttrqIF6QXEhiLw9BQM3cO0tQdz9NHMbaiuCME1mOHl1/ivrw==
X-Gm-Gg: ATEYQzw9cI/x5rXrEoQ+1vdCgryS0aj7qEAIRftoIbIKviN770E2YDhDDC4M5hD0jVX
	ZC4eoQcgS4LK6TSWj0jTDR3v9znJJVkqe6rgfUpwbfOu7ieOkLTLeC9Zxf6w7U3s4R4QtjIixCI
	6DA5FYVh7m8qYbYDjDTXh5p6d+4lTQ9zJcL1lvdLXVnIMDDGz/sZMpN6WwtnMHhfMuVg/WWWE5f
	Sin82FY/dMDZ/pUe98ntOfplXcUPShRI9t+QMGA5ExJSbuHICwqXhFlwhebyoddPvB0m5W0SizD
	A6FXOjNYHqdW4K19ORYzWFe0WiA2nv8C+iyJtXUW0srRA4SC7K6espMQrteaUOKwD08BEue6ZR+
	quurxXRdHlxIR76qwzHP4ZNomX+Jnurt8+Kcl0tdabVsAI5dkX4k+3orEY8FN9ejsjB0s+QRHMw
	pm4JFi1B8rQ5fpDAVVLn9E6QJcw+bSAsd7rWxabazRNFDibuiiDzbPK8cIR631YtwdFA8=
X-Received: by 2002:a05:7022:158c:b0:11a:b4dc:7773 with SMTP id a92af1059eb24-128ed117908mr59874c88.12.1773269065915;
        Wed, 11 Mar 2026 15:44:25 -0700 (PDT)
Received: from google.com (197.23.125.34.bc.googleusercontent.com. [34.125.23.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8a833a22sm5077416eec.7.2026.03.11.15.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 15:44:25 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:44:20 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, atomlin@atomlin.com,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v3] module: print version for external modules in
 print_modules()
Message-ID: <20260311224420.GB2440964@google.com>
References: <20260310023807.80140-1-laoar.shao@gmail.com>
 <aa-6wILF90Y4ndnd@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa-6wILF90Y4ndnd@infradead.org>

On Mon, Mar 09, 2026 at 11:31:28PM -0700, Christoph Hellwig wrote:
> On Tue, Mar 10, 2026 at 10:38:07AM +0800, Yafang Shao wrote:
> > For vmcores triggered by a driver bug, the system calls print_modules() to
> > list the loaded modules. However, print_modules() does not output module
> > version information.
> 
> And it should not.
> 
> >
> > Across a large fleet of servers, there are often many
> > different module versions running simultaneously, and we need to know which
> > driver version caused a given vmcore.
> 
> Then don't run extetrnal modules, which are not a first part citizen.
> Get your changeas upstream instead of just leeching the upstream
> developers work.

As much as I would like to see these modules upstreamed, distributions
do ship out-of-tree modules to users. If adding the OOT module version
to print_modules() helps folks better handle the resulting bug reports,
and maybe even indirectly keeps some of the noise away from upstream, I
feel it's worth the small maintenance burden from this change.

Sami
