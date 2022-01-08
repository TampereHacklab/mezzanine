from django.contrib.auth.models import Group
from django.contrib.sites.models import Site

from mezzanine.core.models import SitePermission

from allauth.account.adapter import DefaultAccountAdapter
from allauth.socialaccount.adapter import DefaultSocialAccountAdapter


class DisableSignUpAccountAdapter(DefaultAccountAdapter):
    """
    Adapter to disable allauth new signups
    Used at settings.py with key ACCOUNT_ADAPTER

    https://django-allauth.readthedocs.io/en/latest/advanced.html#custom-redirects
    """

    def is_open_for_signup(self, request):
        """
        Checks whether or not the site is open for signups.
        """
        return False


class SocialAccountToStaffAdapter(DefaultSocialAccountAdapter):
    def is_open_for_signup(self, request, sociallogin):
        """
        Allow self signup for social login

        We only have keycloack so this should be fine
        """
        return True

    def save_user(self, request, sociallogin, form=None):
        """
        Let super do the heavy lifting and after that add the staff status
        and groups to our user
        """
        u = super().save_user(request, sociallogin, form)

        u = sociallogin.user
        # set as staff
        u.is_staff = True

        # add to SSO group
        sso_group, created = Group.objects.get_or_create(name = 'SSO')
        u.groups.add(sso_group)

        # and give permission to all sites for this user
        for s in Site.objects.all():
            siteperms = SitePermission.objects.create(user=u)
            siteperms.sites.add(s)

        u.save()

        return u
