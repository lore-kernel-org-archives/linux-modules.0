Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBA282F29
	for <linux-modules@vger.kernel.org>; Fri, 29 May 2026 05:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031761; cv=pass; b=H2no0fsq+jlGYLFRQ8XeatmSroiYFFpNjIrvAyiwQQlIUq9Ec1aTUaaV6sZxIZOy8W5yKYZRjp+3D+axlBQZEMtBOi6qKelD583FmckoN+AXLF4IDdNHhUkEiov9Fhs6c3CJkOPhJP0BWDnDekpBBYdTzcK66/9iL2urUkSRHAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031761; c=relaxed/simple;
	bh=RZmlRufzWqXoxl9YMpr3zqfVc7Zbb6YFULZJWEcCPOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJbnzz7LPhv2uyx2zrKwUZqK5M9BcT4difctSgLWfFEJoqhuUWkecK+PS+PqEuswaJgXKZFeeEaZKxThU4ahdjrvEwzgaT+zcW9lrWDd/SjCrXzLL+XQ0xDxcSl2j/0cOK5k9XsRTrgKh8RzSs0N9FMd9XrjtLFNGjUisyT/dQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4SlhRPI; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4SlhRPI"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304e5d3cdfeso33560eec.3
        for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 22:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780031759; cv=none;
        d=google.com; s=arc-20240605;
        b=PNm3jl0fVy+wSSsMdlARndpO4lWQYRvYZSMUfTEDnRij7D4PojXdhMs9RZG3XZOADm
         eeUQySbkvYYeuefffNSB6Y8M/O7wMff4AQckuneXs5xCPYvn2YjBPrU7P+Wb6kphFjtK
         O4BDE/NCAJnEmuN0oqLJ55n2pQ+Cq1O+uX+cpkTiCLdVWLjgzwJEM/kDfYq9irO7dMNc
         MtXYCEajne0KonTW9CWfWmhSEMYx8vTXXf2bt2HtpbHT9PIJLqfclTQOMZm0dkq5BnQT
         UuyKNnaMYb9atGyozakMEZtpJ4U5Vc5bzPCQ9gEDn/uttcqY68b7kUsjxv8nScPVEwVS
         4kEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X+RniAYNsrfL09sn7xlO64xDYFduCytNvTWSC7DXHDQ=;
        fh=hZ+nbPdk2QOJGyOxTaQ7oW2qq9uZsBpxfCcTOCalFac=;
        b=QwKyoUb5xR3zPx/issiHyjHvrxmOqSxekBTKrf+9RaAXjpF2abx2ZWuGf/taLw+6Bh
         T8C3rbSY1/WgnpV13yBHRH2dx0dskGYLOIF52rWCgnRYEv1msV394NnHJxPzrOPO4M3k
         N4fqAlJL/w5qAN3Oo15KNbR/1ma2YknAanFZ4uXa/2SnLD1jAysvbC3FNksaBH3FIKQI
         0SfU5D2w1QQm4yzr5+5jD0pgeE1cpjIZsOmi2AgoK5g3vrxagFXTUjHGHDrcHCZGWDWW
         cgY3Bqpt/9KUW4fuQHK8ti8oYtKuoT713qn9jCcrFgyKtrKxt3zGC8UDWHP/bKsANs7z
         P7ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780031759; x=1780636559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+RniAYNsrfL09sn7xlO64xDYFduCytNvTWSC7DXHDQ=;
        b=U4SlhRPI8XTmVZXLHHfZIx6gIQ6mUh5jjD2P5woLQns6/eJmqPGzF960SXC39ggFJB
         22qnoU9aBityAY2tfJB8d4Eou7Y3n7PenJN4LHarWJ4Vbwryalll51NL1oFonzNEMnsZ
         usc7ti75wL/zMjZhO3XKOGXcv4iqwNGFfizPtP06AEDHhbp0COs8M1GNQ5abn5DJaaBb
         gEKJJvsCD+pcHob+Te3QLBL5ITLT6glIk2W/XtxLbDCrVTnHwsCA5uYhLLsTwUDIHu4W
         90iDppr3ZtwFuelgHnrvioYZbcpVsPd6QoFVijtnQdmfiZSqtEobLicB9C9MXkgIXJe3
         jC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780031759; x=1780636559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+RniAYNsrfL09sn7xlO64xDYFduCytNvTWSC7DXHDQ=;
        b=ZFFSRCKxt/vHTAbSLa4TO/W/xtg8zBwWGlIQpwjfNs9+7Fko8njgJvWUs54N8+EZe3
         cKhtpD2Uy76jPjFsBiUkzwiGjoFMmJZWdLcsfymA2QUpXpXx8uKMnrQBIv5CL2g/d9Mh
         GNXRk9nnuTU18SH2Fsu2GLs0PZUCKzZKWMlWYlHHP9OKJRASvQevanyN1E5o3AKqM/XK
         udmKsA3QFWcbhM0Vp8skeCKT2YY819WJVJ9LxB5YClV4ZQeoxoBs7Uqc9LzkkrHK/ppi
         AFxmM5Ctb9BKRUFUTPj+K8YfYg7lhepl9Kii0mjdGGZHrBRhDxvAdSev/Xn3SX6v7X2c
         z8eg==
X-Forwarded-Encrypted: i=1; AFNElJ8wXK9rMPk/+WSiz+hAIqoae03S5nb86pv6czdqSQQIz0TbiaOH++h+kbrmp7MUcLYLvoHwynNwp4rsyN56@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOjA2/EWXi9FtKk9Yd2I7PmbWJRtoYq4rsKzHi+yXCaejWUFP
	+r8K+t8lxq4PmVTHPqrHT7OIotBd3+WXWrrXE9zh6hGQ8vrTyNiDl6OXWVS8NbGDByvGAKwklkw
	4Eg+zC6x5JCC1CfRRSN717fxK1QQ23bAM8aoX
X-Gm-Gg: Acq92OEDGASjx2G078tuJ7LuFh5K6EiMjEF8FMyAYhyAw9jyundld5vBQPy2dk0XjFE
	wbsyXXNTblc3i+qFIBKdfS2Su0TF6rzbkqwtOnlJmD5K9+uoCrmgxc7TY+RT3TS+lEFQywWO+iG
	p+4buhOJ5zwmxqb5XzVvBszGGrjHlkaqUGGacsSthctvt3/ld3hfQ5HKvdjJ/Y41tWTXCQxBGlC
	zXFCCl0qxH9CRc+5d8hR0i715+hrnGctkSwkpFMXO2EtIqyn/vaavnFijyaQmUXVwuMB4GzbXFv
	WH+J/D6+D20Qp4GMs4bUFbJcJwTqg9YQsZtGHD4RW7t52d6yqOqNB3oBzdSp4Axdd/IdA5Y5LiK
	UCUWCdeS0hFjSDBlj0NtMT3ZgfZ9+BFC57HY+zn42ZLKW
X-Received: by 2002:a05:7301:1288:b0:304:c73b:79ea with SMTP id
 5a478bee46e88-304eb0faad8mr347356eec.3.1780031759297; Thu, 28 May 2026
 22:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521161405.64042-1-SisyphusCode0311@gmail.com>
 <CANiq72m5GZp_p2HCgotBaevLmt1NrvzwrzJJK5sLUEwxeVLBdw@mail.gmail.com>
 <CABCJKue2BvckpFK1yROmOcsrRpxRC9m0OiwCymxF=OW0JZkLUw@mail.gmail.com> <CANN+23v9vkzq_2o01z2VmkDnLaBTP8_Op5vvu=Ozg21T3o6m3w@mail.gmail.com>
In-Reply-To: <CANN+23v9vkzq_2o01z2VmkDnLaBTP8_Op5vvu=Ozg21T3o6m3w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 May 2026 07:15:45 +0200
X-Gm-Features: AVHnY4IXYRmYXeaL2akTBUG-TDhJkn4WVHbKolyP28qYFK0d8D_UpPqyVmWfGaU
Message-ID: <CANiq72kTEQJcxD2iAd97Ly-qh7uRzPn7=k=DUEvHJw=NMFVk8A@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: add missing newline to pr_warn
To: Kenny Glowner <sisyphuscode0311@gmail.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 2:55=E2=80=AFAM Kenny Glowner
<sisyphuscode0311@gmail.com> wrote:
>
> I hope I submitted everything correctly?  I am trying to get used to it s=
o I can provide better assistance on more mainstream issues. That's why I s=
tarted with the most minor issue I could find. I appreciate all of the feed=
back.

Yes, it looks fine, thanks! :)

However, in general, please try to reply to the feedback, e.g. I asked
a question about the commit message.

Cheers,
Miguel
