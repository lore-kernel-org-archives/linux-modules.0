Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166F1D79B7
	for <linux-modules@vger.kernel.org>; Fri, 15 Nov 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688822; cv=none; b=Dr/DOYl1LPC3+FKTnPKjjJT4phRfdb9GbKJ7c7j9mvB958zGCyenRyUFI7WrAAHu3B1xed7Ay3NZ/vbXeR2POR5qbg7BuoDoViknmFA52nH8DzLLSx/X+t1cTKYApCGy7vLcUsydEOCPyaJOohInMeDOG3/sG+GdmIILz6OpVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688822; c=relaxed/simple;
	bh=b0/gJJyyQjJP3pcSFkrnwxvFkdns5mixUfzVHRmn7oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA6tb4VypzmQ5KVYohaioN69tJS65veqhemH6hqxALWB9lr+WrHdOaWydgZy1P3vKeJ2Phzh+MF8haCXDZt1GsM9Ks/OJ8m0tkP1a/FANhr7rEAX+40LtOVqAKwdYHQkOdm0jP+lgGBmm3bDMpraO83Mza4Jl4SE0xMjxL8zivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AZsXd3Kj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AZsXd3Kj"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so1137911f8f.2
        for <linux-modules@vger.kernel.org>; Fri, 15 Nov 2024 08:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731688817; x=1732293617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=170RFOIN/xfN7IZfnc2mXRNJ92+bK44F1urWxzLbiM0=;
        b=AZsXd3Kj7vYQo+Bd3V6LxMQqcqBYzga0IWOvu0pbVkZ3n2noI0biLTxevoRVjQr4yu
         F4tzxMs3iIybXRVb8u6tbOvec4c7CNX6VQyty7RheyBDCAe+9JQ634J1z4eBVwLtv0KI
         bRNxwMHhR7P+lvcnpTnuY2r8uF1OqyFOYXr3YXPfNJ7S8GjZ27MUaxiDQC14KwCUbGUX
         07z1al8HYg5LXfuAvQaM//bOGPNnNogAFfIEq1E+y1nwZHcpVnudjFmLwidbXfLjckun
         6HQ8MTPT6RVprLrGS17Mm5cPxiOu7OiqGMjCm75SFMFoWc1bnepSTVMVtgXwOed9FEYw
         GCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688817; x=1732293617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=170RFOIN/xfN7IZfnc2mXRNJ92+bK44F1urWxzLbiM0=;
        b=kT4ka5QB01cUB7p45pyIe0hKp3P6bBya6ND+4E+Mtt7A4MUpo1xONvqCT7H+gPNkul
         CDowyvIIsweeuk9cKDGVieAXlDOR7EmmFaG1YmYGPOJtXpAAkpxaOeaEdGSjWwyWAHHL
         dsPuc+89O8l4hFbQ/d6G3yegk+fCQu90KFArx01TBUEQZj2E4xURh3EO4ie4Ksz2sgyE
         VfHjoO6JmIboCOrsV34cR8BIE6BqY/XjmlAcPsTsMKFN842z1HogQ2vaK/Exy/hhPoP+
         KpX/dxnb/gbeBlfof5QkWCGjhFPt/0Gyuz6WmOdWXUcNtwKDZrcvYKXTgkh17VnPvqy3
         9E6A==
X-Forwarded-Encrypted: i=1; AJvYcCW7bud+ypWjxQsmGTvJDBg3pCMkuMvWw/5eXO09rV9uEY9x9MxFpziEVMql+QU3XWVwD90NIXLVn8aZuuR8@vger.kernel.org
X-Gm-Message-State: AOJu0YzDq3MsvzF4kiV5RJP/OIT/RrLq9sfb7ncFIIRyXUc1oetM0rk+
	SwuCfWiYjcovW16YEoXk2400yumvltLXhPBaMK/IewlvadBKr7fCqT7NPrCM9d8=
X-Google-Smtp-Source: AGHT+IFUPc9PAhRL6rlHpraKmDxTbG98T6xeZQoU3l6oEoE+2VvXuQga5sYs9SPjCzqPWCEBJKKm0Q==
X-Received: by 2002:a05:6000:1565:b0:37d:38a1:6470 with SMTP id ffacd0b85a97d-38225a91eacmr2579872f8f.46.1731688816947;
        Fri, 15 Nov 2024 08:40:16 -0800 (PST)
Received: from localhost (p200300f65f28bb0063ffae39110fa2df.dip0.t-ipconnect.de. [2003:f6:5f28:bb00:63ff:ae39:110f:a2df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38222a5640csm3289329f8f.104.2024.11.15.08.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:40:16 -0800 (PST)
Date: Fri, 15 Nov 2024 17:40:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com, 
	da.gomez@samsung.com, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@leemhuis.info, vv@tuxedocomputers.com, cs@tuxedo.de
Subject: Re: [PATCH v3 0/2] module: Block some modules by TUXEDO from
 accessing
Message-ID: <uedhiz7luybtelifxooii5efesmpuot3bsoifdutsvt4axyror@zq37gl3x7je2>
References: <20241115130139.1244786-1-wse@tuxedocomputers.com>
 <3023bbda-0902-4e5c-aeb1-074623cd8ff0@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u44ztxo46m4qmee3"
Content-Disposition: inline
In-Reply-To: <3023bbda-0902-4e5c-aeb1-074623cd8ff0@tuxedocomputers.com>


--u44ztxo46m4qmee3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/2] module: Block some modules by TUXEDO from
 accessing
MIME-Version: 1.0

Hello Werner,

On Fri, Nov 15, 2024 at 02:03:27PM +0100, Werner Sembach wrote:
> Am 15.11.24 um 13:58 schrieb Werner Sembach:
> > Following the meeting I wrote about yesterday, I now changed the license
> > of what we could change spontaniously to prove good faith.
> >=20
> > I still hope that the rest can be sorted out before anything gets merge=
d.
> > We are working on it. A clear time window would still be helpfull.
> >=20
> > At Uwe. I don't know how it works if you modifiy someone elses code. I
> > removed the Signed-off-by: line and I guess you have to add it again?

The more usual thing would have been to reply to my mail saying
something like:

	All the code in tuxedo-drivers.git that Tuxedo owns the complete
	copyright for was relicensed to GPLv2+ now. (See $link)
	For the remaining code I'm working in the background towards
	relicensing.

	So please drop

		$modulelist

	from your patch of modules to block.

I'm sure with that feedback you don't risk that the original patch is
applied.

If you take someone else's patch and rework it (which IMHO should only
be done when the original submitter dropped following up to prevent
duplication of work), it's good style to explicitly mention the changes
you implemented since the patch was initially posted. And then don't
remove the S-o-b line. See 7602ffd1d5e8927fadd5187cb4aed2fdc9c47143 for
an example. I think this is (at least partly) also described in
Documentation/ somewhere.

Looking at
https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/co=
mmit/dd34594ab880ed477bb75725176c3fb9352a07eb
(which would be $link mentioned above): If you switch to GPLv2, using
the SPDX-License-Identifier should be good enough (but INAL). For sure
don't put "51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA"
in your files,
https://www.fsf.org/blogs/community/fsf-office-closing-party. Just keep

	You should have received a copy of the GNU General Public License
	along with this program; if not, see <https://www.gnu.org/licenses/>.

which is also the current suggestion by the FSF,
https://www.gnu.org/licenses/old-licenses/gpl-2.0.html.

Thanks for working on this!
Uwe

--u44ztxo46m4qmee3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc3eWwACgkQj4D7WH0S
/k4uQAf+JFBkqTZimsBnHa0edLEECbw1CPo0vACnfPb7OuCEPgStCkHFBEtTd4zM
Aw2neONOmPVE1D+zpdXcI32wRbo5okSyJeQjtiZHDLCLsytK36h3uoNn9WdaOu+E
VukZs3qPidafqg2ZNTh0kR/Y/z3pahShXLgnmQCl9+4F2v5EUa5JwvvM97ZSFcG0
NqddYnOe4K9VGOwI9j6OHYUc+FwklPmgf3yzSF0pPwiszgrGXJCBKZGkrumoYFrf
hOxelLeIYGox+5u1LAc20zwJ7HEpNmstbOMNGZ4HFNecS0kUMUxGSyfvcpUtfg7B
lwqUUO6vWM84WKQfDgiidxAbPPxISg==
=Sjp8
-----END PGP SIGNATURE-----

--u44ztxo46m4qmee3--
