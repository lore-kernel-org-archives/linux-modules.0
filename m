Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792827182;
	b=klbLe+bn+a1fanG+4uezuyzwUBg0Owfec5IOfZoxPTEzgar/OwlNVIk2yNgjWdIBIYpH
	 5RPnVNYdQ1c35fGqj32HCWU8o44YwOZjdwnJ1gwa6k/uCfQt/oPN2cntXL3XNoOMoeJIY
	 ssYJV2XeR/Xg7fAoU2Z2ZU3j91Vb5JfDTIYessOpwsX7EpgJi5YW497CenqJkfdIFA1ye
	 VHMyUaCfU0rq1WTJjNTMNO4kf+S6dLAsIwIKEKTMANsJ29pUQqn2PtQZxzR+6GsDsFlj/
	 3jQmfZPNtD4011QnE4uoBmQk5t+T82RGPH4uGsnldtAOZFcIiSv7xqamKFqtXJmAXJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792827182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=li2QB09lPsjXluSnSfXMvObkOrNnmZZOmi28fPXekeo=;
	b=GcOqawikaXNFCTvDcdvw12RpvcLJmXuA/DbUp3vaVq/oNXlV4xiQ6GKa5JmnXtLRfVPr
	 c1B6l+NOF71HoK58ORljI12Sd/rfaIx/+1ppsxogSOegwi8EhYemYglMDuKyBhrnlBKiJ
	 6ft6VDfN/wpNR4QQAKgKz8Z1Ltyd+5ttXo0s+gVF+d1FLHjwa+ioyu9jzhVUgIiqb/IoW
	 6G7RkLroKlIzp21Feo9mc6FL6p+vrC3zpiIpyVtEit7jY7CMaZmJv+C7Hyb3mhbmGkEoZ
	 NBBZor/bkSiF/H6tO8npDepLuQbNxyGRKhqM9NVrAojoM6sWeQx59hKCdgeXyaEViHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B42606A320
	for <linux-modules@vger.kernel.org>; Sat, 24 Oct 2026 07:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B42606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so882384f8f.3
        for <linux-modules@vger.kernel.org>; Sat, 24 Oct 2026 00:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792827174; x=1793431974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=li2QB09lPsjXluSnSfXMvObkOrNnmZZOmi28fPXekeo=;
        b=bIDYtbOnPGADlrjGilR6HlFVpF/eIp31wIxr3wVKS/McxWVagsZZJcNMwIGOaDkaGh
         jPydXHn40ca3LBrlABACC/cWWoUxiiNQ6K37TuAZ9OwdOWByTtGVMcTPttbPs/rrEPpo
         lJ60v1+90zWJIUQbjPMADewT4OKMmnJWfpxYytolFHNH7DWkKldRUsZyWrhDofT7/PhB
         hnOIsKB4wTNr035cZj+SICgnq++LdGkxL98N7LJaydych2gY8QLXItAv1k93WeYHehTv
         Ds3pnjJrMgM8GsA9BuPW6XaI9nQwpsSBGPGmFcNOQnnUl7tbCIZ3e6bA8AfUd7KMXs7D
         IkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792827174; x=1793431974;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=li2QB09lPsjXluSnSfXMvObkOrNnmZZOmi28fPXekeo=;
        b=xx39eKGD3c+nv3ereZo4liC8x400Ki6AoenUbd58OxMyJ1dkIa+Nh1M2dJOWbE9Rrw
         ZMYryl7u3vdDv3GLol5OMGWwjNHvtGjysKteDYYYHDgf3kIg7/2tF6R2u7hOtPU1YVN4
         mC39smR6Nl/Vppj/vfQDXdjA1EHm0xZGQInF7Z031mNm0ksSmXDYxUhrgu+FsD65b6px
         z8IkqmB6bKDOSWT9vxN1e0CxhwJfAguTKIHAd2Jp/bUZ9qDT/l/V3XMksssE5Arn2tdI
         lT5zervJ3qATz6GpVi7GbbZl/IC2lpWN0+p2x3CcAsVDsFHroYa9l3CZ4NZGkGuiowOK
         dNzg==
X-Forwarded-Encrypted: i=1; AKwUvBzs+bNc2waUw/4qq/OZb8AylYkdQ/JpxmNOPhMBwcsw6tKoHGuVt9Ei658eFjJYhABZMaij7cUssMxp7MRo@vger.kernel.org
X-Gm-Message-State: AFq9FYJDEDx23ZZ8n6gr2kTqT/e3lHRcaQMBg61TkOgo1u5MLdZ5Vtjt
	bhxMOadFmFjzHFt2s/oG2dX3VCKNgbjQZaN7/emUhUG1xny5gSOJUXvunZx/q4YF40c=
X-Gm-Gg: AYBFou1aZQTLKVwwE8yjO9DwAzTY4xIdi0eIzT6E1q1aP6pX1rvm6cFkpaSemxlbknI
	6SHKzvMOk0MJJ5waEpi4wZN+pUnBZwV7000SLcWoUSlTML1Xm4Fx51LCpUGnZ2opb+R+X5nZP6m
	i0N7LouQQZuhbFZeHBKyO+JsebuNVHRs4Mmpn0QKrnfytT5dL2FSz8270ylEvhg7rd4PSe72Dlo
	+uFEI6Rebx68Oklren0en7hUNpv3/ErjMrt+vphMmRJSyrKWhjH0VYonG42Hd/tbWO8B56OsKpO
	6rhB5ieTuOCilOytySrDl2hWapzxiHyFcVfLR6T6DSc9Cx6oMpBLviUje837JDYTo3yxBxH5dXj
	8jWkV96xzfwlsTfQIDP1RaR+cqxqR0gI8YrYtoZtMlavzcEU1eusMaq55SMB4n9+PXq3izXepT+
	C4eIZZaaoFy2pU1fS1BfbzmJmmimDX0HrLvuIMQCgGjMeg+SKoG5p1QtIHvUSwi8LRbAZOfaWIc
	0aQQUsHR9KL7h8hFLyKpNJkkyp8x9v790sas8PbTjrYPbJkNQ6o7HauHkk9iKB+ORyYby/cgTJA
	wPrge9ql13S7UgHVzBZ6mMiCST4hvuV0dF8=
X-Received: by 2002:a05:6000:40e1:b0:48e:932:aefa with SMTP id ffacd0b85a97d-48e3eb9263fmr1987532f8f.26.1792827174053;
        Sat, 24 Oct 2026 00:32:54 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ecd35c2sm2752126f8f.39.2026.10.24.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 00:32:53 -0700 (PDT)
Date: Sat, 24 Oct 2026 09:32:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alex Williamson <alex@shazbot.org>, Armin Wolf <W_Armin@gmx.de>, 
	David Lechner <dlechner@baylibre.com>, Danilo Krummrich <dakr@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Thierry Reding <thierry.reding@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <atxdQ4vfh-b6GD0B@monoceros>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="snd5d5o342ief275"
Content-Disposition: inline
In-Reply-To: <2026102437-vista-unsoiled-b089@gregkh>


--snd5d5o342ief275
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
MIME-Version: 1.0

Hello Greg,

On Sat, Oct 24, 2026 at 06:56:34AM +0200, Greg Kroah-Hartman wrote:
> We have real problems with random "bind/unbind" attempts that this taint
> is here to help resolve as it was creating hundreds of false-positive
> bug reports on developers all across the tree now that the fuzzers
> decided to think this was a valid action to take.  Without this taint,
> people were being forced to add hacks to all drivers for this which is
> not an acceptable solution.

Why is it false positive? IMHO unless it involves a driver_override it
is a bug to fix. So have you considered tainting on driver_override
instead of bind/unbind? You did, I'm sure because several peoplel voiced
that approach already, but unless I missed something, you didn't share
your thoughts about it yet.

https://lore.kernel.org/all/cover.1790612298.git.u.kleine-koenig@baylibre.com/
would be a suitable thread to share your opinion.

Best regards
Uwe

--snd5d5o342ief275
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrcXyAACgkQj4D7WH0S
/k6DIAf8DAU1k1OUjt0oOb7bxXYD1+h/zw0y3dtkGS8G+zRTS/qzzPPjfmqRP0h9
J5L7m6Y88ojmkEkaTuZykFHJjTD0oRB1HPOJTgCW6xGNMm2ZWeh0nTUKgD9H5GY7
w2HgqDafsFSbrwjrivGi8AGwp3WErwD0r+kOCr0MrPDA9d4RxztnKRXgDPP79VFz
52dVyEVot3hTvhqxMfO0yLVcwGhQaO5VnfAGO3zqb7oOJoL3MzMUVk3Qo8NuSz6R
zP04L1Pg9uTjUgCUKeKGGkzd/2+nMfGXjUGnId1rwsRI7WfBXP4t0r6JIOZsSNIY
RuU/lvGyyvYfTEwZjc1S5kWfcRrIdw==
=5xdK
-----END PGP SIGNATURE-----

--snd5d5o342ief275--
