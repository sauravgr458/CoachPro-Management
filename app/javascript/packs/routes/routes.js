import React from 'react';
import Login from '../pages/login';
import SignUp from '../pages/signUp';
import AcceptInvitation from '../pages/acceptInvitation';
import CompanyLanding from '../pages/companyLanding';
import ProgramDetails from '../pages/programDetails';
import Dashboard from '../pages/dashboard';

export const PublicRoutes = [
  {
    path: '/',
    element: <Login />,
  },
  {
    path: "/login",
    element: <Login />,
  },
  {
    path: "/company/:company_slug/sign-up",
    element: <SignUp />,
  },
  {
    path: '/users/invitation/accept',
    element: <AcceptInvitation />
  },
  {
    path: '/company/:company_slug',
    element: <CompanyLanding />
  },
];

export const CoachRoutes = [
  {
    path: 'coach/dashboard',
    element: <Dashboard />,
  },
  {
    path: 'coach/company/:company_slug/program/:program_slug',
    element: <ProgramDetails />
  }
];

export const EmployeeRoutes = [
  {
    path: 'employee/dashboard',
    element: <Dashboard />,
  },
  {
    path: 'employee/company/:company_slug',
    element: <CompanyLanding />
  },
  {
    path: 'employee/company/:company_slug/program/:program_slug',
    element: <ProgramDetails />
  }
];
