Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A6167D97
	for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885590; cv=none; b=n5vdiMgwuu97odC91s+JCID72NSMatZY6RNZHGsWy3l3vCt+CjLw0A3/p6zS9pO4jiLWu5huwLNvi/COARm8yx8InFuvpY8Ftzw5ADqLh50kqWXPVM1eAncgcVZ1zcgMMQ3JOCZUaSAtBkY9qnO0nTuz3u3lzqR05kotXnksV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885590; c=relaxed/simple;
	bh=vBcDKzqZD0IGH+kMo+OOysCrPxyHMCAFpcXSn+OPSOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGeQ8evrJHd9e5lbvOx0AduZLrY3qfRtvbc3W/Q7xwchFMP2TbYyZ0ImwYY3L8MtBL1PCE6q/jZt1pknpV7ngdO5eSihG8gJ9zDb9HFoX6RV5aMqmkZm8JuwIasGpcyPyk38ghN/CMCc0oGAT1jVuLq0HgmiPzhOmjFb0TY2HYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2O4GfF7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2O4GfF7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20260346ca1so76945ad.0
        for <linux-modules@vger.kernel.org>; Wed, 28 Aug 2024 15:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724885588; x=1725490388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nAbDwChQbWZl01mr4KnwFnysig2L5blgWIiA7h1UA+g=;
        b=d2O4GfF7WopxCnqOqwsLLniMZHCWPaQPvt3QIdMi9YZJEaqqeR649XtcrztBfCf9pU
         kAtum6pMD/WYzjSXmPMS6gfRJfqy3ugo074qqigzq7jsj7zZr0XcuT1mhg+tr7OV9elY
         a9Q6d+jrqmjd6d3sdJV0xWFfcLDw8mmqCujW/lyEbrB5AJ4AEqlM7dzsznVNcJ43Qbab
         OQwFuJyfQWDk3cuo+TzqsTN0uhtrH7eBpqtvebW3yXpKQHlG88snSzU8TD+sK8iz3Ehr
         twQOQBMJxEz+np6I3dLHVZBcyMyOCApLKo77SIlJNJPjSd0V3m6+TMHMK/Fp9tMYi+Sj
         mvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724885588; x=1725490388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAbDwChQbWZl01mr4KnwFnysig2L5blgWIiA7h1UA+g=;
        b=w8ocrftUDEd6L14LDVldkPX97QT331QdBv5KKjY2YrCDVkP1xSk20JxiuI/oTRT7cL
         6cb1pLxcBC1Fj1nT5ALLHqh9S6GeFHO7jrpWJpqPaH8onODGLW1f58PSG9QSrNLhLMUI
         MjdIhvk5coj6OPPHXjIeFwr8W6fXg1J+klsBFd1z5AD5A6n5WgmQrmp3SB65hwmTRvQF
         dkmRxR0F+JtLPo23goai4m1svHoSaaiC1DorKOnQNxbOZpYOPwO2/nE5qkHYTOd86TON
         OBWmKWO0LgCVZKApRyn5ZzggqExsxZe7JlYGZxFIA4HLV46eYdtUo5tIP2bhf8AY5dXl
         eAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Pyn6FdI1rmiBiq4Gfov05Vw81QWXBra/axNs+DlyjL5fhhDcLvB2v3VmjX3eBMGWpMcG+zJ40JmmftmU@vger.kernel.org
X-Gm-Message-State: AOJu0YzKvPYkN4TotRbmvXvZhY7tj1L3tQDP489534lJmiQNf2TNMV7U
	MiMRqrmcETOKDjSlY+ISfNFUusQsIISlGxC9n1GmaQQgSm9HH0sEu18f87O9pQ==
X-Google-Smtp-Source: AGHT+IEQaTc+wud0mzSYI+hEe/4PWmz2+rLLZ8+Mx8YVlCteMCgZHZsbCbUbqJpRqiB0krS+Bxb7ZQ==
X-Received: by 2002:a17:902:e849:b0:1e0:c571:d652 with SMTP id d9443c01a7336-20510a7f2e1mr522765ad.1.1724885587784;
        Wed, 28 Aug 2024 15:53:07 -0700 (PDT)
Received: from google.com (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557eec1sm104064935ad.91.2024.08.28.15.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 15:53:07 -0700 (PDT)
Date: Wed, 28 Aug 2024 22:53:02 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Maurer <mmaurer@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 00/19] Implement DWARF modversions
Message-ID: <20240828225302.GH2130480@google.com>
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <CAK7LNAQ0dHq3eALkvGDSCyVKOvhBqwCEG3BTQ0h52Xq_1YNu2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQ0dHq3eALkvGDSCyVKOvhBqwCEG3BTQ0h52Xq_1YNu2A@mail.gmail.com>

Hi Masahiro,

On Wed, Aug 28, 2024 at 04:04:09PM +0900, Masahiro Yamada wrote:
> On Fri, Aug 16, 2024 at 2:39 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > The first 16 patches of this series add a small tool for computing
> 
> 
> Splitting a new tool into small chunks makes line-by-line review difficult.

I split this into smaller pieces to make it less of a chore to
review, but I'm also happy to squash these into larger patches if you
prefer. How would you like to see this split instead?

> For example, 02/19 adds malloc().
> 
> 03/19 immediately replaces it with calloc().
> 
> Then, I wonder why you did not add calloc() in the first place.

Yes, that wasn't ideal, but like I said in my other response, I tried
to keep the churn minimal. Please let me know if you spot any other
annoyances.

> And, I do not think it is so "small".
> It is bigger than the current genksyms.

In my defense, the first version was smaller, but sure, I'll drop the
false advertising from the cover letter now that it has more features.

> > symbol versions from DWARF, called gendwarfksyms. When passed a
> > list of exported symbols and an object file,
> 
> 
> Why is "a list of exported symbols" passed separately?
> 
> All necessary information is available in the object file.
> (The export symbols are listed in the .export_symbol section.

Unfortunately this is not the case for Rust object files where exports
are handled separately. Passing the list of symbols as input feels
more flexible to me, and also is rather convenient for debugging.

> > - Added a --symtypes flag for generating a genksyms-style
> >   symtypes output based on Petr's feedback, and refactored
> >   symbol version calculations to be based on symtypes instead
> >   of raw --dump-dies output.
> 
> 
> 
> I do not know if this is worthwhile.

Greg, Petr, do you want to comment on the usefulness of the symtypes
output? I was under the impression it was a useful tool for figuring
out exactly what caused the versions to change?

> And, it is obviously a build error.
> 
> gendwarfksyms cannot create %.symtypes from %.c.

Ah, this obviously needs to depends on the .o files instead. I'll sort
this out in v3.

Thanks for taking a look!

Sami
