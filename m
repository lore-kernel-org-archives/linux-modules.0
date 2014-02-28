Return-Path: <mmarek@suse.cz>
Message-ID: <53102F6F.7010300@suse.cz>
Date: Fri, 28 Feb 2014 07:40:47 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/5] testsuite: Check the list of loaded modules after
 a test
References: <1393541533-14719-1-git-send-email-mmarek@suse.cz> <1393541533-14719-2-git-send-email-mmarek@suse.cz> <CAKi4VAKOh5n9qWjLj1PpO3c0b1xzQOEMdKuD0Fe=C0a2tHmUAQ@mail.gmail.com>
In-Reply-To: <CAKi4VAKOh5n9qWjLj1PpO3c0b1xzQOEMdKuD0Fe=C0a2tHmUAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Dne 28.2.2014 07:32, Lucas De Marchi napsal(a):
> On Thu, Feb 27, 2014 at 7:52 PM, Michal Marek <mmarek@suse.cz> wrote:
>> +       qsort(a1, l1, sizeof(char *), cmp_modnames);
>> +       qsort(a2, l2, sizeof(char *), cmp_modnames);
>> +       for (i = 0; i < l1; i++)
>> +               if (cmp_modnames(&a1[i], &a2[i]) != 0)
>> +                       goto out_a2;
> 
> Isn't the order important? If we take the order into account the code
> could be even simpler because we don't even have to store the char **.
> Just build the second string with ',' as separator and strcmp() them.

The readdir() order is not defined. We could change the preloaded
init_module to build another list of modules that maintains order, but
I'm not sure if it's worth it. I will simplify the allocations as you
suggest.

Michal
