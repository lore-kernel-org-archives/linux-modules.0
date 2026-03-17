Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4833FD149
	for <linux-modules@vger.kernel.org>; Tue, 17 Mar 2026 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789032; cv=none; b=J5plxk25vEiUJjSj+TwVmF16ojUkg1dJ4r21A954Ae7901G2vRsZWlqH5kjbBs59OBi3VodliU9PObd5i0TAZxpNvGcrnakuRpjz89O1hkVml6jRVWU/eAsw2njSLXzdo6JQgkjk4Zs4U9CR/z+mR8RFeuu/zhWLyQFtsegDE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789032; c=relaxed/simple;
	bh=tt7O6t7NekN5N65hLRsCmkrDnLwNsIQoSm9JQyFLJvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvF/yT/JV56agZG8TGDpXj43krJzBuS4CCQbo66UOzT73Po2gFzUFlW0IL+qDdFBNi8V20A6/mnmWP81wLHSb66pYdOJJSPowcAMye3LSE2t3mKm1IQR1kTIQNLjM/ImKj88P4lkbfZSfYMdXRfjaNUdewbSYboB7wQFo0Z8mHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gu7JG031; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gu7JG031"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aeab6ff148so21365ad.1
        for <linux-modules@vger.kernel.org>; Tue, 17 Mar 2026 16:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773789031; x=1774393831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDC55F9nNxOp6pJr51JvJ3pIh7ij1MEPDvN1YIIr6lU=;
        b=Gu7JG031DokP/gwv62+v4AFUBex3Crk1ApDTfj2MQjauwxXpnmQVbi5me/xl3KV526
         i64Rhz1YqntPxn/HlekFpWUY26LlMM5ip5+vWVudy0LcS8DHm4XS+aRf7n3+O5O0UEZA
         LFNxLsMYnUC2ONMUl3FGcRGW1x0b/Uv1weH4YjoAWNCejySV/B0qzVAtFXFHKeyy+256
         NPWxMlfk8MSGLcILqmvPSZO27XA3Y+T/YcZfZ7gS6SzweH720+j/TaM2wPNjDVsMCkTN
         Sruqb3fA7RCbbt3jRyQANxzI4xavke2JzxkUAKipTMyd3Ng+Cl5K+0qPn7Gjw33KCFW6
         BSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789031; x=1774393831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDC55F9nNxOp6pJr51JvJ3pIh7ij1MEPDvN1YIIr6lU=;
        b=X4lnixISaZ5oTnnplrnFcefifGUrrNJWIU9pyvLdGxf2phERxzJof7NYP+AQHWe1Ua
         9FbnskwV4ra5+XrwhUF0whKUk5cK7Bsw4eQI17ZABhTSmUtN/yz343n2a6WQmiEt5QSM
         FFs0NE5lzvkciRKq8CBWI/jgHlzNkMKvLgLulIqTH5pRBq3kZTytiuDTqdYDq4icVvQc
         l5wbNbYwhMXGs0TuBLwrb5Hqq02eha67cLTTl2v5816px4yKZv6L0DFr5eRt2yXXD/Tg
         ZESXogECW2xa4m0T9vvBMoGLO70bZM0LutmfzPHEw/Ti/E+kELk2vcQzNj4syZHMCmjY
         7R2A==
X-Forwarded-Encrypted: i=1; AJvYcCWrsuoD920EJpfkHXUSlB+05dVTXBDaTmAegBRZ3aU7rjUwNNSpUY2nKEhZfyLUrPkmi1GTsZEI0nhNXU5t@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkmlK7Kxh41j4I0bQGrpihWu8ZmteR+qM5E0N6bicS7kzI5P3
	JNFcLawRxwjq/p3voslK2QPD2eBI/CkrDoHAH2a37sv3RbKazr/JyyYWA6vCLrjpyw==
X-Gm-Gg: ATEYQzwUV+aYjlxbO8UBdVTYyaeu60QBQBeJbntH9ow5lDqIM2w3rnqnV9iy4UuBsQV
	7qizRJEQThFCmGSl3qDpL1Bxrt7vsYMQYbyzzl9uXYdsW+QJSgbfnRjvTGcvdtqu8CZFoIkI/ej
	6S+/wpe6p94LDD04sibp703WH34XTBuzgyC191f3zSTtSEdUFsyUs1araboTjmOHp9mak2ZuEIO
	9BO6k5EuNK9gUoVIsyzR1sCdKWQz72wt9ljb/Cn9o9FvFuoGGai9eoSRTNz2fNLiY2EW+6IYgPg
	Dq3+SvljJqDbEZH1LhLRLz2cX02L9bl3w84HUlkfF67PQaBdMShLdEk7WFMVZITHc+6yU3S4o6j
	Zv5CU5T5mA1cMLz7lp6/tzXNgY+JCY/QfJY5UsbkY+zGVsHX6WVeUXFNuMuGULrn0sFRe7Iuew/
	fhCLZNdt1upURl2NInrOXR11Lt9s+pjO8CcPAhtzkJA3NshaV6FCA66ubvJhg60WoW5kAhKFMUf
	V8vVQ==
X-Received: by 2002:a17:903:1a06:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2b06e871446mr1378655ad.12.1773789030114;
        Tue, 17 Mar 2026 16:10:30 -0700 (PDT)
Received: from google.com (197.23.125.34.bc.googleusercontent.com. [34.125.23.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e6315dcsm7467705ad.80.2026.03.17.16.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:10:29 -0700 (PDT)
Date: Tue, 17 Mar 2026 23:10:24 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] module.lds,codetag: force 0 sh_addr for sections
Message-ID: <20260317231024.GA2507155@google.com>
References: <20260305015237.299727-1-joe.lawrence@redhat.com>
 <20260311211207.GA2440964@google.com>
 <3969f887-4d3d-4fb8-870d-6af834d120e5@suse.com>
 <jl7b2iy44nakt6qiyytncemcym22aoddrjixblxcrfgjnnfc3k@vpmf2yfnrokr>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jl7b2iy44nakt6qiyytncemcym22aoddrjixblxcrfgjnnfc3k@vpmf2yfnrokr>

On Tue, Mar 17, 2026 at 03:55:57PM -0700, Josh Poimboeuf wrote:
> On Mon, Mar 16, 2026 at 03:23:20PM +0100, Petr Pavlu wrote:
> > Nonetheless, this can be done separately. I think fixes for these files
> > should better go through architecture-specific trees anyway.
> > 
> > I can check the individual architectures and prepare the necessary
> > patches, unless someone else is already looking into this or wants to
> > take a look.
> 
> I agree those can be done separately.  In the meantime do you plan to
> take this patch in the module tree?

Yes, that's the plan.

Sami
