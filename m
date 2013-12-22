Return-Path: <bebl@mageta.org>
Message-ID: <52B7728D.50406@mageta.org>
Date: Mon, 23 Dec 2013 00:15:25 +0100
From: Benjamin Block <bebl@mageta.org>
Reply-To: bebl@mageta.org
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: Can't load modules with parameters given
References: <52B33B88.2090306@mageta.org> <CAKi4VAKHuVKnWzo0qU5dy+WcYMogFZv67V6gy9OqobjuiETP-g@mail.gmail.com>
In-Reply-To: <CAKi4VAKHuVKnWzo0qU5dy+WcYMogFZv67V6gy9OqobjuiETP-g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uC9ldKfJomnHKJxN2hv4XHBt7iw4V4UWi"
List-ID: <linux-modules.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uC9ldKfJomnHKJxN2hv4XHBt7iw4V4UWi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/22/2013 10:16 PM, Lucas De Marchi wrote:
> Hi Benjamin,
>=20
>=20
> On Thu, Dec 19, 2013 at 4:31 PM, Benjamin Block <bebl@mageta.org> wrote=
:
>> Hi,
>>
>> I have a rather strange problem currently. I am trying to load a modul=
e
>=20
> strange indeed
>=20
>> with some parameters (bnx2x with disable_tpa=3D1) and it fails because=

>> this parameter is unknown according to dmesg. But modinfo lists this
>> exact paramter and it is also included in the source. And while this i=
s
>> not an in-tree driver, I could also replicate the same behavior with
>=20
> are you sure modinfo and modprobe are reading the same module? maybe
> you updated your modules between the operations?
>=20

pretty sure. It shows the exact path to the .ko, because this is a
out-of-tree driver that is not located under /lib/modules/..
And in case of the bonding-example, there is no other module anywhere
else with the same name.

>=20
>> in-tree device drivers (like bonding with the parameter tx_queues):
>>
>> $ modprobe bonding # works fine
>> $ rmmod bonding
>> $ modprobe bonding tx_queues=3D32
>> modprobe: ERROR: could not insert 'bonding': Unknown symbol in module,=

>> or unknown parameter (see dmesg)
>>
>> and dmesg tells me:
>>         bonding: Unknown parameter `tx_queues'
>> and nothing else (as with bnx2x, this parameter is listed by modinfo).=

>>
>> Is there some obvious kernel-config-option I could have messed up or
>> something else like this?
>=20
> So... this changed in recent kernels (3.11 -- see the commit message
> that introduced this behavior below)... we don't fail to load a module
> anymore due to unknown option. So if/when you upgrade you won't see
> this problem anymore.
>=20
> Anyway, it shouldn't fail for you like it did, but it might as well be
> a problem of the particularly patched kernel you are using... not
> sure.
>=20
>=20
>>
>> I am using a Gentoo-Userspace kmod (v15) with a Ubuntu-Kernel (3.8.13.=
13
>> - this is a version with some ubuntu-patches applied) - I know, the
>> combination is rather strange. Any ideas?
>=20
> the combination is not a problem and should work just fine.
>=20

I am now certain that this is a specific and/or combination of
kernel-configuration-options which is messing this up here. I have a
debug- and a release-configuration with the only difference that the
debug-config contains several kernel-hacking-features enabled that the
release doesn't include (compiled with symbols, lockdep, tracing and
stuff like this). And in the release-config I could load the module with
the parameter given.

When I'm at work again I will figure out which config messes this up
exactly (I don't have access to the machines right now).


- Benjamin


--uC9ldKfJomnHKJxN2hv4XHBt7iw4V4UWi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQGcBAEBAgAGBQJSt3KsAAoJEEbgTgVnoy6e4N8MAIzItHSh8N+/TjTUAEfaJSrt
tL8hYfDcBEZNvqA9HAts/2sYO3dr0nmfRZFBuhCAMfTMZfvb/UOZen9Eqc5ZmUON
9C9iBwhKMZxSRevebMXcuz6S8U084LLWSXLGSHedIemqpYmY79A5oJTl8/9OQxFi
G8I1Cp2G50zK39NCFrr4k6+cgWDQVl53d8obEDZ3uQ3URbfsOvGdRY5kNCkcXpLo
N8QxpWw/aq1ZDPw6Cy9nTH0WEcnlBySCPRZ+cWT0384Bs1QPlnCk0SlXNIk8ge9B
SU113mlPInUNhBsKeSwKLUne0rS2o/RhC++dRAHBCN18hOpXQKiLVWooq2bYxAV0
1fgNdI2E8kPxhKNIARReeXVAWeOvkrol68RfverFEC19RkT/ivrIWP817HXZZ/9E
2ZI3zvpmFvw1JcMT09fOutJTe6x8l41yMtNCFGe5MfK2EjO/3okxIhwo4zhFg84t
ysDk+VGZvj5JMgWILMyVrhib/b2/tta5CILBZZ2xOg==
=yAxL
-----END PGP SIGNATURE-----

--uC9ldKfJomnHKJxN2hv4XHBt7iw4V4UWi--
